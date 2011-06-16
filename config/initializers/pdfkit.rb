require 'pdfkit'

PDFKit.configure do |config|
  config.wkhtmltopdf = AppConfig.wkhtmltopdf.path
  config.default_options = {
      :page_size => 'Legal',
      :print_media_type => true
  }
end