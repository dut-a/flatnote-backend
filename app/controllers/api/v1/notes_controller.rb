class Api::V1::NotesController < ApplicationController

  def index
    notes = Note.all
    if (notes.length > 1)
      result = { json: notes, :include => {
            :user => { :only => [:username] }
          },
          :except => [:created_at, :updated_at]
      }
    else
      result = { json: {"status": :no_content, "message": "No notes available."} }
    end
    render(result)
  end

  def show
    note = find_note
    if note
      final_json = { json: note, :include => {
        :user => { :only => :username }
      }, :except => [:created_at, :updated_at] }
    else
      final_json = { json: get_404_error_msg }
    end
    render(final_json)
  end

  def create
    note = Note.create(note_params)
    if note.valid?
      render json: { note: NoteSerializer.new(note) }, status: :created
    else
      render json: { error: 'Unable to create the note' }, status: :not_acceptable
    end
  end

  private
    def note_params
      params.require(:note).permit(:title, :notes, :tags, :user_id)
    end

    def find_note
      Note.find_by(id: params[:id])
    end

    def get_404_error_msg(msgTxt = "Note not found.")
      return { "status": 404, "message": msgTxt };
    end

end

