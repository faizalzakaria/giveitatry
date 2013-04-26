class RoomController < ApplicationController

  def show
    img_cnt = Image.count;
    max_room = img_cnt / Giveitatry::Application.config.limit_per_room
    if img_cnt % Giveitatry::Application.config.limit_per_room != 0
      max_room += 1
    end
    max_room -= 1

    @images = Image.order("updated_at DESC").limit(Giveitatry::Application.config.limit_per_room).offset(params[:id].to_i * Giveitatry::Application.config.limit_per_room)
    room_id_next = [params[:id].to_i + 1, max_room].min
    room_id_prev = [params[:id].to_i - 1, 0].max
    @room_id = {
      :next => room_id_next,
      :prev => room_id_prev
    }

    respond_to do |format|
      format.html { render :layout => 'index', :template => 'images/index' }
      format.json { render :layout => 'index', :template => 'images/index', json: @images, json: @room_id }
    end
  end

end

