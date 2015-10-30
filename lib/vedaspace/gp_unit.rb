# <xsd:complexType name="GpUnit" abstract="true">
#   <xsd:sequence>
#     <xsd:element name="ComposingGpUnitId" type="xsd:IDREF" minOccurs="0" maxOccurs="unbounded"/>
#     <xsd:element name="ExternalIdentifiers" type="ExternalIdentifiers" minOccurs="0"/>
#     <xsd:element name="Name" type="xsd:string" minOccurs="0"/>
#     <xsd:element name="SummaryCounts" type="SummaryCounts" minOccurs="0" maxOccurs="unbounded"/>
#   </xsd:sequence>
#   <xsd:attribute name="objectId" type="xsd:ID" use="required"/>
# </xsd:complexType>
module Vedaspace::GpUnit
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do    
    define_element("ComposingGpUnitId", type: Vedaspace::GpUnitComposingGpUnitIdRef, method: :gp_unit_composing_gp_unit_id_refs)
    
    define_element("ExternalIdentifiers", type: Vedaspace::ExternalIdentifierCollection, method: :external_identifier_collection)
    
    define_element("Name")
    
    define_element("SummaryCounts", type: Vedaspace::SummaryCount, method: :summary_counts)
    
    define_attribute("objectId", required: true)
  end
  
end
