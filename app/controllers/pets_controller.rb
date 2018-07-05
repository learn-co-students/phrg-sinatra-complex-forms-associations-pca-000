# frozen_string_literal: true
require 'pry'
class PetsController < ApplicationController
  get "/pets" do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get "/pets/new" do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post "/pets" do
    @pet = Pet.new(name: params["pet_name"])

    if params["owner_name"] == ""
      @owner = Owner.find(params["pet"]["owner_ids"])
      @pet.owner_id = @owner.id
      @owner.pets << @pet

    else
      @owner = Owner.new
      @owner.name = params["owner_name"]
      @owner.save
      @pet.owner_id = @owner.id
      @owner.pets << @pet
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get "/pets/:id/edit" do
    # binding.pry
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get "/pets/:id" do

    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post "/pets/:id" do
    puts params
    @pet = Pet.find(params[:id])


    if params[:owner_name] == "" && params[:pet_name] == ""
      @pet.owner_id = params["@owner_id"]
      @pet.save

    elsif params[:owner_name] == ""

      @pet.update(:owner_id => @owner_id)
      @pet.update(:name => params["pet_name"])
    else
      @owner = Owner.new(:name => params["owner_name"])
      @pet.owner = @owner
      @pet.save
    end

    # if !params["pet"]["name"].empty?
    #   @owner.pets << Pet.create(name: params["pet"]["name"])
    # end
    redirect to "pets/#{@pet.id}"
  end
end
