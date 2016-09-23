require 'graph-reader'

require_relative 'edge'

# Normal Graph class
class Graph
  attr_accessor :edges, :nodes

  def initialize(params = {})
    gr = GraphReader::Graph.new(params[:edges_filepath])
    @nodes = gr.nodes
    @edges = []
    adding_edges(gr.edges)
    
    @dim = @edges.first.attrs.size unless @edges.empty?

    @neighbors_hash = set_neighbors
    @adj_matrix = gr.adj_matrix
    @edges_hash = {}
    set_edges_hash(@edges_hash)
  end

  def add_node(node)
    @nodes << node unless @nodes.include?(node)
  end

  def adding_edges(edges)
    edges.each do |e|
      add_edge(e)
    end
  end

  def add_edge(read_edge)
    new_edge = Edge.new

    new_edge.id    = read_edge.id
    new_edge.src   = read_edge.src
    new_edge.dst   = read_edge.dst
    new_edge.attrs = read_edge.attrs

    @edges << new_edge
  end

  def find_neighbors_at(node)
    @neighbors_hash[node]
  end

  def set_neighbors
    n_hash = {}
    nodes.each do |node|
      n_hash[node] = find_neighbors(node)
    end
    n_hash
  end

  def set_edges_hash(e_hash)
    @edges.each do |e|
      e_hash[[e.src, e.dst]] = e
      e_hash[[e.dst, e.src]] = e
    end
  end

  def find_neighbors(node)
    neighbors = []
    @edges.each do |edge|
      neighbors << check_neighbor(node, edge)
    end
    neighbors.compact!
  end

  def check_neighbor(node, edge)
    case node
    when edge.src
      return edge.dst
    when edge.dst
      return edge.src
    end
  end

  def find_edge(src, dst)
    @edges.each do |edge|
      return edge if edge.src == src && edge.dst == dst
      return edge if edge.src == dst && edge.dst == src
    end
    raise ArgumentError, "not connect between #{src} and #{dst}"
  end

  def partition(path)
    result = []
    0.upto(path.size - 2) do |i|
      result << [path[i], path[i + 1]]
    end
    result
  end

  def same_edge?(edge1, edge2)
    edge1_src_id = edge1.src
    edge1_dst_id = edge1.dst
    edge2_src_id = edge2.src
    edge2_dst_id = edge2.dst
    return true if edge1_src_id == edge2_src_id && edge1_dst_id == edge2_dst_id
    return true if edge1_dst_id == edge2_src_id && edge1_src_id == edge2_dst_id
    false
  end
end
