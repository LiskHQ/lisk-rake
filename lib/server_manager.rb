module CryptiKit
  class ServerManager
    def initialize(task)
      @task = task
      @list = ServerList.new
    end

    def list
      @task.info 'Listing available server(s)...'
      @list.values.each do |server|
        node = Node.new(server)
        @task.info node.info
      end
      @task.info '=> Done.'
    end

    def add
      @task.info 'Adding server(s)...'
      @chooser = ServerChooser.new(:values)
      @list.add_all(@chooser.args)
      @task.info 'Updating configuration...'
      @list.save
      @task.info '=> Done.'
    end

    def remove
      @chooser = ServerChooser.new(:keys)
      @task.info 'Forgetting server(s)...'
      @list.forget_all(@chooser.choose)
      @task.info 'Removing server(s)...'
      @list.remove_all(@chooser.choose)
      @task.info 'Updating configuration...'
      @list.save
      @task.info '=> Done.'
    end

    def log_into(server)
      @task.info "Logging into #{server.hostname}..."
      system "ssh #{Core.ssh_options(server)}"
      @task.info '=> Done.'
    end
  end
end
