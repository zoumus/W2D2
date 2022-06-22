require_relative "room"

class Hotel

    attr_reader :rooms

    def initialize(name, room_names_capacity)
        @name = name
        @rooms = {}
        
        room_names_capacity.each do |room_name, capacity|
            @rooms[room_name] = Room.new(capacity)
        end
    end

    def name
        @name.split.map(&:capitalize).join(' ')
    end

    def room_exists?(room_name)
        return true if @rooms.has_key?(room_name)
        false
    end

    def check_in(person, room_name)
        if !room_exists?(room_name)
            print 'sorry, room does not exist'
        else
            if @rooms[room_name].add_occupant(person)
                print 'check in successful'
            else
                print 'sorry, room is full'
            end
        end
    end

    def has_vacancy?
        @rooms.values.each do |instance|
            return true if instance.available_space != 0
        end
        false
    end

    def list_rooms
        @rooms.each do |k, v|
            puts "#{k}: #{v.available_space}"
        end
    end
  
end
