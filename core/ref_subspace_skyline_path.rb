require_relative 'subspace_skyline_path'

require 'json'

class RefSubspaceSkylinePath < SubspaceSkylinePath
  attr_reader :ref_paths
 
  def initialize(params = {})
    super
    read_ref_paths
  end

  def read_ref_paths
    file = File.read("ref-path-data/top_5.json")
    @ref_paths = JSON.parse(file).map { |k , v| {JSON.parse(k) => v} }
  end

end