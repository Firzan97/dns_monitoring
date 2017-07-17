class DeleteWorker
  include Sidekiq::Worker

  def perform(question)
    question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'DNS was successfully removed.' }
      format.json { head :no_content }
  end
end
end
