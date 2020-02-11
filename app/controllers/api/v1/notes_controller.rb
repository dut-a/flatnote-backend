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
      render json: { 
        "errors": note.errors,
        "error_codes": note.errors.keys.map { |f| "#{f.upcase}_ERROR" },
        "error": 'Unable to create the note' }, status: :not_acceptable
    end
  end

  def update
    note = find_note
    if note
      # Note found, proceed with other operations on it...
      note.update(note_params)
      if note.valid?
        result = { json: {
            "status": 200,
            "message": "Note updated successfully",
            "note": note
          }
        }
      else
        result = { json: { "status": 400, "message": "Bad request" } }
      end
    else
      result = { json: get_404_error_msg }
    end
    render(result)
  end

  def destroy
    note = find_note
    if note
      # Note found, proceed with other operations on it...
      if note.destroy
        final_json = { json: { "status": 204, "message": "Note titled '#{note.title}', successfully deleted." } }
      else
        final_json = { json: get_404_error_msg("Unable to delete the note '#{note.title}'.") }
      end
    else
      final_json = { json: get_404_error_msg }
    end
    render(final_json)
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

