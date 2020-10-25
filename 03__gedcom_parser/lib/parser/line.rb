class GedcomParser
  module Parser
    # This class is responsible to know how to parse a Gedcom line
    class Line
      def call(line_data)
        # TODO Validate input data

        parts = line_data.split(' ')

        result = {
          level: fetch_level(parts)
        }

        if line_has_id?(line_data)
          GedcomParser.logger.debug { "#{self.class} - Parsing Line with ID: #{line_data}" }

          result.merge!(attribute: fetch_id(parts))
          result.merge!(tag: fetch_type(parts))
        else
          GedcomParser.logger.debug { "#{self.class} - Parsing Normal Line #{line_data}" }

          result.merge!(tag: fetch_tag(parts))
          result.merge!(value: fetch_value(parts))
        end

        result
      end

      private

      def fetch_level(parts)
        Integer(parts.first)
      end

      def fetch_id(parts)
        parts[1].split('@')[1]
      end

      def fetch_type(parts)
        parts.last
      end

      def fetch_tag(parts)
        parts[1]
      end

      def fetch_value(parts)
        parts[2..-1].join(' ')
      end

      def line_has_id?(line_data)
        line_data.include?('@')
      end
    end
  end
end
