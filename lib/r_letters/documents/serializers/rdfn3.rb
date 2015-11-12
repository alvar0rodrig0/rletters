require 'r_letters/documents/serializers/rdf'
require 'rdf/n3'

module RLetters
  module Documents
    module Serializers
      # Convert a document to an RDF/N3 record
      class RDFN3 < RDF
        define_single(:n3, 'RDF/N3',
                      'http://www.w3.org/DesignIssues/Notation3.html') do |doc|
          ::RDF::Writer.for(:n3).buffer do |writer|
            if doc.is_a? Enumerable
              writer << doc.each { |d| to_rdf_graph(d) }
            else
              writer << to_rdf_graph(doc)
            end
          end
        end
      end
    end
  end
end
