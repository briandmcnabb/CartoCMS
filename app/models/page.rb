class Page < ActiveRecord::Base

  # Constants
  LOCALES  = I18n.available_locales.map(&:to_s)
  FORMATS  = Mime::SET.symbols.map(&:to_s) - %w(multipart_form url_encoded_form)
  HANDLERS = ActionView::Template::Handlers.extensions.map(&:to_s)


  # Accessors
  attr_accessible :body, :format, :handler, :locale, :partial, :path, :publish_date, :publish_time, :title
  attr_writer :publish_date, :publish_time

  def publish_date
    @publish_date ||= published_at.try(:strftime, '%m/%d/%y')
  end

  def publish_time
    @publish_time ||= published_at.try(:strftime, '%I:%M %P')
  end

  def virtual_filepath
    underscore = partial ? '_' : ''
    [path, format, locale, handler].join('.').insert(0, underscore)
  end


  # Validations
  validates :title,   presence: true
  validates :body,    presence: true, unless: "published_at.nil?"
  validates :path,    presence: true
  validates :locale,  inclusion: LOCALES
  validates :format,  inclusion: FORMATS
  validates :handler, inclusion: HANDLERS


  # Associations
  has_many :assets, as: :attachable
  has_many :images, as: :attachable

  # Callbacks
  before_validation :set_default_filepath, on: :create
  before_update :set_published_at
  after_save :clear_resolver_cache


  # Scopes
  scope :published, lambda { where("published_at < ?", Time.now.to_date ) }



  private

  # Methods
  def clear_resolver_cache
    Page::Resolver.instance.clear_cache
  end

  def normalized_datetime
    [@publish_date, normalized_time].join(' ')
  end

  def normalized_time
    @publish_time.gsub(/\A0+/, '')
  end

  def set_default_filepath
    self.partial = false
    self.path    = "pages/#{title.parameterize}"
    self.locale  = "#{I18n.default_locale}"
    self.format  = "html"
    self.handler = "erb"
  end

  def set_published_at
    if @publish_date && @publish_time
      self.published_at = Chronic.parse(normalized_datetime)
    end
  end



  class Resolver < ActionView::Resolver
    require "singleton"
    include Singleton

    def find_templates(name, prefix, partial, details)
      conditions = {
        path:    normalize_path(name, prefix),
        locale:  normalize_array(details[:locale]).first,
        format:  normalize_array(details[:formats]).first,
        handler: normalize_array(details[:handlers]),
        partial: partial || false
      }

      ::Page.published.where(conditions).map do |record|
        initialize_template(record)
      end
    end

    # Normalize name and prefix, so the tuple ["index", "users"] becomes
    # "users/index" and the tuple ["template", nil] becomes "template".
    def normalize_path(name, prefix)
      prefix.present? ? "#{prefix}/#{name}" : name
    end

    # Normalize arrays by converting all symbols to strings.
    def normalize_array(array)
      array.map(&:to_s)
    end

    # Initialize an ActionView::Template object based on the record found.
    def initialize_template(record)
      source = record.body
      identifier = "Page - #{record.id} - #{record.path.inspect}"
      handler = ActionView::Template.registered_template_handler(record.handler)

      details = {
        format:       Mime[record.format],
        updated_at:   record.updated_at,
        virtual_path: virtual_path(record.path, record.partial)
      }

      ActionView::Template.new(source, identifier, handler, details)
    end

    # Make paths as "users/user" become "users/_user" for partials.
    def virtual_path(path, partial)
      return path unless partial
      if index = path.rindex("/")
        path.insert(index + 1, "_")
      else
        "_#{path}"
      end
    end
  end
end