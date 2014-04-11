require 'spec_helper'
require_relative '../../../lib/import_export/metadata_xml_parser'

describe MetadataXmlParser do
  describe "::file_valid?" do
    it "doesn't allow duplicate file names"
    it "finds ActiveFedora errors for each record"
    it "requires a model type (hasModel)"
    it "requires valid xml"
    it "returns an array of human readable error messages"
  end

  describe "::parse_file" do
    it "returns the correct number of records"
    it "returns the record class, attributes and line number for each node"
  end

  describe "::get_namespaces" do
    it "converts datastream namespaces to the format Nokogiri wants"

    # if the typos in the namespaces get fixed, we can remove this test and
    # the corresponding code
    it "doesn't modify namespaces if they have been fixed in the project"
  end

  describe "::get_record_attributes" do
    # We're patching ActiveFedora to store the dsid on ActiveFedora::Base#defined attributes.
    # We need this to look up so we know how attributes are stored for each of the defined
    # models. This is used in the xml import stuff in metadata_xml_parser.rb.
    it "should patch ActiveFedora until we upgrade to version 7" do
      # If this test is failing, you can:
      # * remove the ActiveFedora::Attributes::ClassMethods.create_attribute_reader monkeypatch
      # * remove the ActiveFedora::Attributes::ClassMethods.create_attribute_setter monkeypatch
      # * update MetadataXmlParser to use .dsid instead of [:dsid], and
      # * remove this test.
      expect(ActiveFedora::VERSION.split('.').first).to be < 7.to_s
    end

    it "merges in the pid if it exists"
    it "returns the record class for a given node"
  end

  describe "::get_node_content" do
    it "gets the content for attributes from the given node"
        #TODO TuftsDcaMeta.new.description has multiples, use this as a test case

    it "gets the content for attributes when a private method exists with the attribute's name"
        #TODO TuftsDcaMeta.new.format was a problem, use this as a test case
  end
  describe "::get_pid" do
    it "gets the pid"
    it "raises if the pid already exists"
  end

  describe "::get_file" do
    it "gets the filename"
    it "raises if <file> doesn't exist"
  end

  describe "::get_record_class" do
    it "raises if <hasModel> doesn't exist"
    it "raises if the given name doesn't correspond to a record class"
    it "returns a class"
  end
end
