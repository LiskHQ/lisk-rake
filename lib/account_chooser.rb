module LiskRake
  class AccountChooser
    def initialize(task, node)
      @task = task
      @node = node
    end

    def choose
      puts divider
      puts Color.light_blue("Available accounts on:\s") + Color.green("Node[#{@node.key}]")
      puts divider

      if @node.accounts.empty? then
        @task.warn 'No accounts available...'
      else
        puts choices
        puts
        puts Color.yellow("Please choose an account [#{range}]:")
        choice = Core.gets.match(/[0-9]+/i)[0].to_i rescue nil
        puts divider

        if choice then
          @node.accounts[choice - 1]
        else
          return nil
        end
      end
    end

    def choices
      accounts = @node.accounts.map.with_index do |value,index|
        "#{index + 1}: #{value['address']}"
      end
    end

    def self.choose(task, node)
      self.new(task, node).choose
    end

    private

    def divider
      '-' * 80
    end

    def range
      "1-#{@node.accounts.size}"
    end
  end
end
