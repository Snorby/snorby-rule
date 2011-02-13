module Snorby
  module Rule

    module Database

      module Migrations
        
        migration 1, :create_rule_table do
          up do
            create_table :rule do
              column :id, Integer, :serial => true
              column :sid, Integer
              column :rev, Integer
              column :body, Text
            end

            create_index :rule, :sid, :unique => true
            create_index :rule, :rev, :unique => true
          end

          down do
            drop_table :rule
          end
        end

      end

    end

  end
end
