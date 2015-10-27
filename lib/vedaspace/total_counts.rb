module VSSC
  class TotalCounts < Counts
    include VSSC::ClassAttributes
    define_attribute("ballotsCast", type: Fixnum)
    define_attribute("overvotes", type: Fixnum)
    define_attribute("undervotes", type: Fixnum)
    define_attribute("writeIns", type: Fixnum)
  end
end