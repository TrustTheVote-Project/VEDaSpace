module VSSC
  class CandidateCollection
    include VSSC::ClassAttributes
    define_element("Candidate", :multiple=>true, :type=>Candidate, :min_size=>1)
  end
end