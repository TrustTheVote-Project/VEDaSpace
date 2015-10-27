module VSSC
  class PartyRegistration
    include VSSC::ClassAttributes
    define_element("Party")
    define_attribute("object_id", required: true)
    define_attribute("count", required: true, type: Fixnum)
    
  end
end