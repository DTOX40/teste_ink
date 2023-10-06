# spec/models/store_spec.rb

require 'rails_helper'

RSpec.describe Store, type: :model do
  describe "validations" do
    it "is not valid without a name" do
      store = Store.new(name: nil, description: "Description")
      expect(store).not_to be_valid
      expect(store.errors[:name]).to include("can't be blank")
    end

    it "is not valid without a description" do
      store = Store.new(name: "Store Name", description: nil)
      expect(store).not_to be_valid
      expect(store.errors[:description]).to include("can't be blank")
    end

    it "is valid with a name and description" do
      store = Store.new(name: "Store Name", description: "Description")
      expect(store).to be_valid
    end
  end

  describe "database" do
    it "can save a valid store" do
      store = Store.new(name: "Valid Store", description: "Valid Description")
      expect(store.save).to be true
    end

    it "cannot save an invalid store" do
      store = Store.new(name: nil, description: "Invalid Description")
      expect(store.save).to be false
    end
  end
end
