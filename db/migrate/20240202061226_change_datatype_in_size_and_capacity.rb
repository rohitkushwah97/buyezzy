class ChangeDatatypeInSizeAndCapacity < ActiveRecord::Migration[6.0]
  def up
    BxBlockCatalogue::SizeAndCapacity.all.each do |size_and_capacity|
      size_and_capacity.update(size: size_and_capacity.size.to_i, capacity: size_and_capacity.capacity.to_i)
    end

    change_column :size_and_capacities, :size, 'integer USING CAST(size AS integer)'
    change_column :size_and_capacities, :capacity, 'integer USING CAST(capacity AS integer)'
  end

  def down
    change_column :size_and_capacities, :size, :string
    change_column :size_and_capacities, :capacity, :string
  end
end
