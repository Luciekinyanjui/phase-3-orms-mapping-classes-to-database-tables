class Song

  attr_accessor :name, :album
  attr_accessor :name, :album, :id

  def initialize(name:, album:)
  def initialize(name:, album:, id: nil)
    @id = id
    @name = name
    @album = album
  end

  Filter changed files
  1  
 .results.json
 @@ -0,0 +1 @@
 {"version":"3.10.1","examples":[{"id":"./spec/song_spec.rb[1:1:1]","description":"the name attribute can be accessed","full_description":"Song when initialized with a name and a albun the name attribute can be accessed","status":"passed","file_path":"./spec/song_spec.rb","line_number":14,"run_time":0.008988049,"pending_message":null},{"id":"./spec/song_spec.rb[1:1:2]","description":"the album attribute can be accessed","full_description":"Song when initialized with a name and a albun the album attribute can be accessed","status":"passed","file_path":"./spec/song_spec.rb","line_number":18,"run_time":0.000347752,"pending_message":null},{"id":"./spec/song_spec.rb[1:1:3]","description":"sets the initial value of id to nil","full_description":"Song when initialized with a name and a albun sets the initial value of id to nil","status":"passed","file_path":"./spec/song_spec.rb","line_number":22,"run_time":0.000327909,"pending_message":null},{"id":"./spec/song_spec.rb[1:2:1]","description":"creates the songs table in the database","full_description":"Song.create_table creates the songs table in the database","status":"passed","file_path":"./spec/song_spec.rb","line_number":28,"run_time":0.008066303,"pending_message":null},{"id":"./spec/song_spec.rb[1:3:1]","description":"saves an instance of the Song class to the database","full_description":"Song#save saves an instance of the Song class to the database","status":"passed","file_path":"./spec/song_spec.rb","line_number":40,"run_time":0.023979833,"pending_message":null},{"id":"./spec/song_spec.rb[1:3:2]","description":"assigns the id of the song from the database to the instance","full_description":"Song#save assigns the id of the song from the database to the instance","status":"passed","file_path":"./spec/song_spec.rb","line_number":46,"run_time":0.022767578,"pending_message":null},{"id":"./spec/song_spec.rb[1:3:3]","description":"returns the new object that it instantiated","full_description":"Song#save returns the new object that it instantiated","status":"passed","file_path":"./spec/song_spec.rb","line_number":52,"run_time":0.022752219,"pending_message":null},{"id":"./spec/song_spec.rb[1:4:1]","description":"saves a song to the database","full_description":"Song.create saves a song to the database","status":"passed","file_path":"./spec/song_spec.rb","line_number":62,"run_time":0.023391747,"pending_message":null},{"id":"./spec/song_spec.rb[1:4:2]","description":"returns the new object that it instantiated","full_description":"Song.create returns the new object that it instantiated","status":"passed","file_path":"./spec/song_spec.rb","line_number":67,"run_time":0.022919369,"pending_message":null}],"summary":{"duration":0.137420121,"example_count":9,"failure_count":0,"pending_count":0,"errors_outside_of_examples_count":0},"summary_line":"9 examples, 0 failures"}
   1  
 Gemfile.lock
  BIN +0 Bytes (100%) 
 db/music.db
 Binary file not shown.
  37  
 lib/song.rb
 @@ -1,10 +1,43 @@
 class Song
 
   attr_accessor :name, :album
   attr_accessor :name, :album, :id
 
   def initialize(name:, album:)
   def initialize(name:, album:, id: nil)
     @id = id
     @name = name
     @album = album
   end
 
   def self.create_table
     sql = <<-SQL
       CREATE TABLE IF NOT EXISTS songs (
         id INTEGER PRIMARY KEY,
         name TEXT,
         album TEXT
       )
     SQL
     DB[:conn].execute(sql)
   end
 
   def save
     sql = <<-SQL
       INSERT INTO songs (name, album)
       VALUES (?, ?)
     SQL
 
     # insert the song
     DB[:conn].execute(sql, self.name, self.album)
 
     # get the song ID from the database and save it to the Ruby instance
     self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
 
     # return the Ruby instance
     self
   end
 
   def self.create(name:, album:)
     song = Song.new(name: name, album: album)
     song.save
   end

end
