require 'moneta'

module Perjantai
  class EventNode
    attr_reader :timestamp, :data, :prev

    def initialize(timestamp: Time.now.strftime('%Q'), data:, prev:, hash: nil)
      @timestamp = timestamp
      @data = (data || {}).symbolize_keys
      @prev = prev

      return if hash.blank? || self.hash == hash

      raise 'Invalid entry'
    end

    def hash
      @hash ||= Digest::SHA256.hexdigest([@index.to_s, @timestamp, JSON.dump(@data), @prev].join('|'))
    end

    def serialize
      JSON.dump(
        timestamp: @timestamp,
        data: @data,
        prev: @prev,
        hash: hash
      )
    end

    def self.deserialize(data)
      new(JSON.parse(data).symbolize_keys)
    end
  end

  class EventChain
    def initialize(id)
      @id = id
    end

    def add_link(data)
      node = EventNode.new(data: data, prev: last)

      store.store(key('node', node.hash), node.serialize)

      self.last  = node.hash
      self.first = node.hash if first.nil?
    end

    def last
      store.fetch(key('last'))
    end

    def last=(id)
      store.store(key('next', last), id) unless last.nil?
      store.store(key('last'), id)
    end

    def next_node(id)
      key = store.fetch(key('next', id))
      return nil if key.nil?
      node(key)
    end

    def node(id)
      raw = store.fetch(key('node', id))
      EventNode.deserialize(raw)
    end

    def first
      store.fetch(key('first'))
    end

    def first=(id)
      store.store(key('first'), id)
    end

    def each
      return if first.nil?
      current = node(first)

      until current.nil?
        yield(current.data)
        current = next_node(current.hash)
      end
    end

    def key(*key_parts)
      "#{@id}_#{key_parts.join('_')}"
    end

    def store
      self.class.store
    end

    def self.store
      @store ||= Moneta.new(:Memory)
    end
  end
end
