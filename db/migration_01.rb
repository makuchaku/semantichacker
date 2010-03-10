require "fastercsv"

class Migration01 < ActiveRecord::Migration
  def self.up
    create_table :semantic_signatures do |t|
      t.column :category, :string
    end

    csv = FasterCSV::parse(File.open("db/signatures.csv").read)
    csv.each do |sig|
      puts "[#{sig[0]}] => #{sig[1]}"
      SemanticSignature.create(:category => sig[1])
    end
  end


  def self.down
    drop_table :semantic_signatures
  end
end

# To run the migration, uncomment...
# Would not be needed if the Sqlite DB is not to be updated (its already populated)
# Migration01.down
# Migration01.up