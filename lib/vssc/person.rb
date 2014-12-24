module VSSC
  class Person
    include VSSC::ClassAttributes
    define_element("Party" )
    define_element("Contact", :multiple=>true, :type=>Contact)
    
    define_attribute("object_id", required: true)
    define_attribute("ethnicity", type: EthnicityType)
    define_attribute("firstName")
    define_attribute("gender", type: GenderType)
    define_attribute("lastName", required: true)
    define_attribute("middleName")
    define_attribute("prefix")
    define_attribute("profession")
    define_attribute("nickname")
    define_attribute("title")
    define_attribute("suffix")
  end
end