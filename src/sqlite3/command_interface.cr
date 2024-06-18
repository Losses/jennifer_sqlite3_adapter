require "jennifer/adapter/db_command_interface"

module Jennifer
  module SQLite3
    class CommandInterface < Adapter::DBCommandInterface
      def create_database
        options = [db_path, "VACUUM;"] of Command::Option
        command = Command.new(
          executable: "sqlite3",
          options: options
        )
        execute(command)
      end

      def drop_database
        options = [db_path] of Command::Option
        command = Command.new(
          executable: "rm",
          options: options
        )
        execute(command)
      end

      def generate_schema
        options = [db_path, ".schema"] of Command::Option
        command = Command.new(
          executable: "sqlite3",
          options: options
        )
        result = execute(command)

        if result[:output].is_a?(IO::Memory)
          output_string = result[:output].to_s
          filtered_output = output_string.each_line.reject { |line| line.includes?("sqlite_sequence") }.join("\n")
      
          File.write(config.structure_path, filtered_output)
        else
          raise "Unexpected output type: #{result[:output].class}"
        end
      end

      def load_schema
        options = [db_path] of Command::Option
        command = Command.new(
          executable: "sqlite3",
          options: options,
          in_stream: "cat #{config.structure_path} |"
        )
        execute(command)
      end

      def database_exists?
        File.exists?(db_path)
      end

      private def db_path
        File.join(config.host, config.db)
      end
    end
  end
end
