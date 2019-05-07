# frozen_string_literal: true

# frozen string literal

class PetsController < ApplicationController
  get "/pets" do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get "/pets/new" do
    erb :'/pets/new'
  end

  post "/pets" do
    @pet = Pet.create(params[:pet])
    unless params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect "pets/#{@pet.id}"
  end

  get "/pets/:id" do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post "/pets/:id" do
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    unless params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect "pets/#{@pet.id}"
  end

  get "/pets/:id/edit" do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end
end
