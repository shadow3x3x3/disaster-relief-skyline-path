require_relative '../lib/dijkstra'

class RefGraph < Graph
  include Dijkstra

  attr_reader :ref_edges, :ref_paths

  def initialize(graph, ref_nums)
    @nodes = graph.nodes
    @edges = graph.edges
    @edges_hash = graph.edges_hash
    @ref_edges = find_ref_edges(@edges, ref_nums)

    @ref_paths     = {}
    @ref_path_attr = {}
    find_all_ref_path
  end

  private

  def find_ref_edges(edges, ref_nums)
    (edges.sort_by { |e| e.min_attrs })[0...ref_nums]
  end

  def find_all_ref_path
    @nodes.each do |n|
      puts n
      @ref_edges.each do |re|
        query_ref_path(n, re.src) unless n == re.src
        query_ref_path(n, re.dst) unless n == re.dst
      end
    end
  end

  def query_ref_path(src, dst)
    temp_ref_path = shorest_path_query(src, dst)
    set_ref_path(src, dst, temp_ref_path) unless temp_ref_path == nil
  end

  def set_ref_path(src, dst, path)
    @ref_paths[[src, dst]] = path
  end
end


