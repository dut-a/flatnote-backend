class Api::V1::NotesController < ApplicationController

  def index
    notes = Note.all
    if (notes.length > 1)
      render json: notes

      # TODO: How do I make this customization not break serialization?
      # render json: {
      #   "status": 200,
      #   "message": "All available notes.",
      #   "note_count": notes.length,
      #   "notes": notes
      # }
    else
      render json: {
        "status": 204,
        "message": "No notes available."
      }
    end
  end

  def show
    note = find_note
    if note
      render json: note
    else
      render json: get_404_error_msg()
    end
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
      params.require(:note).permit(:title, :details, :tags, :user_id)
    end

    def find_note
      Note.find_by(id: params[:id])
    end

    def get_404_error_msg(msgTxt = "Note not found.")
      return { "status": 404, "message": msgTxt };
    end

end

