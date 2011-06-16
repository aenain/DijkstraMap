class AdipController < ApplicationController
  respond_to :html, :pdf

  def report
    @apartments = ApartmentsCreator.new.apartments
    @statistics = Statistics.new(:apartments => @apartments, :trust => 0.05, :predicted => 7600)

    respond_to do |format|
      format.html
      format.pdf {
        html = render_to_string :action => "report", :layout => false
        kit = PDFKit.new(html, :page_size => 'A4')

        pdf = kit.to_pdf
        send_data(pdf, :filename => "is2010_topic7", :type => "application/pdf", :disposition => "attachment")
      }
    end
  end
end
