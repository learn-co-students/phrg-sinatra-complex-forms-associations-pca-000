# frozen_string_literal: true

class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.new(params[:pet])
    if !params[:owner][:name].empty?
      new_owner = Owner.create(name: params[:owner][:name])
      @pet.owner = new_owner
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do

    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.create(params[:pet])
    unless params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect "pets/#{@pet.id}"
  end
end
