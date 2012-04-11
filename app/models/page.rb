class Page < ActiveRecord::Base
  include CartoCMS

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

  def set_default_filepath
    self.partial = false
    self.path    = "pages/#{title.parameterize}"
    self.locale  = "#{I18n.default_locale}"
    self.format  = "html"
    self.handler = "erb"
  end

  def set_published_at
    self.published_at = Chronic.parse(normalized_datetime)
  end

  def normalized_datetime
    [@publish_date, normalized_time].join(' ')
  end

  def normalized_time
    @publish_time.gsub(/\A0+/, '')
  end

  def clear_resolver_cache
    Page::Resolver.instance.clear_cache
  end
end