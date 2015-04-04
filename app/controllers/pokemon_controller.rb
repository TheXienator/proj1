class PokemonController < ApplicationController
	def capture
		p = Pokemon.find(params[:id])
		p.trainer_id = current_trainer.id
		p.save
		redirect_to root_url
	end

	def new
		@p = Pokemon.new
	end

	def create
		@p = Pokemon.create(pokemon_params)
		@p.health = 100
		@p.level = 1
		@p.trainer_id = current_trainer.id
		if @p.save
			redirect_to trainer_path(current_trainer)
		else
			render "new"
		end
	end

	def damage
		p = Pokemon.find(params[:id])
		puts p.health.to_s
		p.health -= 10
		puts p.health.to_s
		if (p.health <= 0) 
			p.destroy
		else
			p.save
		end			
		redirect_to trainer_path(p.trainer_id)
	end

	private

	def pokemon_params
		params.require(:pokemon).permit(:name)
	end
end
