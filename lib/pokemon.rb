class Pokemon
    attr_accessor :id, :name, :type, :db

    def initialize(id:, name:, type:, db:)
        #binding.pry
        @id = id
        @name = name
        @type = type
        @db = db
    end
    
    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
        SQL
        db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT * 
            FROM pokemon
            WHERE id = ?
        SQL
        db.execute(sql, id).map do |row|
            # binding.pry
            Pokemon.new(
                :id => row[0],
                :name => row[1],
                :type => row[2],
                :db => db
                )
        end.first #to actually return it
    end
end