class GisPoster < GenericTischDeposit

  self.attributes = [:title, :degrees, :schools, :departments, :courses, :methodological_keywords, :geonames,
                     :term, :year, :topics, :geonames_placeholder,
                     :degree,
                     :description, :creator, :contributor, :embargo,
                     :bibliographic_citation, :subject, :attachment, :license]
  #def copy_attributes
  #  super
  #  @tufts_pdf.description = ["#{description}  Submitted in partial fulfillment of the grant requirement of the Tufts Summer Scholars Program."]
  #end

  def copy_attributes
   attributes = self.class.attributes
   @tufts_pdf.title= send(:title) unless send(:title).nil?
   @tufts_pdf.description= (send(:degrees).nil? ? '' : send(:degrees)) + (send(:courses).nil? ? '' : send(:courses))
   @tufts_pdf.creator= [(send(:creator) unless send(:creator).nil?)]
   @tufts_pdf.license= license_data(@tufts_pdf)
   @tufts_pdf.subject= (send(:schools).nil? ? '' : send(:schools)) + (send(:departments).nil? ? '' : send(:departments)) + (send(:topics).nil? ? '' : send(:topics)) + (send(:methodological_keywords).nil? ? '' : send(:methodological_keywords))
   @tufts_pdf.geogname= send(:geonames) unless send(:geonames).nil?
   @tufts_pdf.type= ['text']





   case @term
     when 'Fall'
       date_created = @year +'-09-01 00:00:00 -0400'
     when 'Summer'
       date_created = @year +'-06-01 00:00:00 -0400'
     when 'Spring'
       date_created = @year +'-01-01 00:00:00 -0500'
     else
       date_created = @year +'-01-01 00:00:00 -0500'
   end

   @tufts_pdf.date_created= date_created
   insert_rels_ext_relationships

#      if @tufts_pdf.class.defined_attributes[attribute].multiple
#        @tufts_pdf.send("#{attribute}=", [send(attribute)])
#      else
#        @tufts_pdf.send("#{attribute}=", send(attribute))
#      end
#    end

  end

  public
  attr_accessor *attributes
end
