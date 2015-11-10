# <xsd:complexType name="CountStatus">
#   <xsd:sequence>
#     <xsd:element name="Status" type="CountItemStatus"/>
#     <xsd:element name="Type" type="CountItemType"/>
#     <xsd:element name="OtherType" type="xsd:string" minOccurs="0"/>
#   </xsd:sequence>
# </xsd:complexType>
module Vedaspace::CountStatus
  extend InclusionTracking
  extend ActiveSupport::Concern
  include XsdFunctions  
    
  included do
    self.node_name = 'CountStatus'
    
    define_element("Status", type: Vedaspace::Enum::CountItemStatus)
    define_element("Type", type: Vedaspace::Enum::CountItemType, method: :count_item_type)
    define_element("OtherType")
  end
  
end
