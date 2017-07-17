class PerformancesController < ApplicationController
  before_action :set_performance, only: [:show, :edit, :update, :destroy]

  # GET /performances
  # GET /performances.json
  def index
    
    @question = Question.find(params[:question_id])
    @performance = @question.performances
    @performances = @question.performances.order(:created_at).paginate(:page => params[:page], :per_page => 30)
    
    

        @detail=Detail.find_by(question_id: @question.id)
        @average=@detail.average
        @highest=@detail.maximum
        @lowest=@detail.minimum
        @count=@detail.total_query
        @unavailable=@detail.total_fail
        @availability=@detail.status
        @fail=100-@availability

       
        #######For piechart ######
        @success1=@question.performances.where('created_at >=?',DateTime.now.beginning_of_day).count
        @success2=@question.performances.where('created_at >=?',2.day.ago).where('created_at <=?',1.day.ago).count
        @success3=@question.performances.where('created_at >=?',3.day.ago).where('created_at <=?',2.day.ago).count
        @success4=@question.performances.where('created_at >=?',4.day.ago).where('created_at <=?',3.day.ago).count
        @success5=@question.performances.where('created_at >=?',5.day.ago).where('created_at <=?',4.day.ago).count
        @success6=@question.performances.where('created_at >=?',6.day.ago).where('created_at <=?',5.day.ago).count
        @success7=@question.performances.where('created_at >=?',7.day.ago).where('created_at <=?',6.day.ago).count
        @weeksuccess=@question.performances.where('created_at >=?',7.day.ago).count
        @weekfail=@question.performances.where(responsetime: -1 ).where('created_at >=?',7.day.ago).count
        @weekAvailability=((@weeksuccess-@weekfail)/@weeksuccess)*100

        @fail1=@question.performances.where(responsetime: -1 ).where('created_at >=?',DateTime.now.beginning_of_day).count
        @fail2=@question.performances.where(responsetime: -1 ).where('created_at >=?',2.day.ago).where('created_at <=?',1.day.ago).count
        @fail3=@question.performances.where(responsetime: -1 ).where('created_at >=?',3.day.ago).where('created_at <=?',2.day.ago).count
        @fail4=@question.performances.where(responsetime: -1 ).where('created_at >=?',4.day.ago).where('created_at <=?',3.day.ago).count
        @fail5=@question.performances.where(responsetime: -1 ).where('created_at >=?',5.day.ago).where('created_at <=?',4.day.ago).count
        @fail6=@question.performances.where(responsetime: -1 ).where('created_at >=?',6.day.ago).where('created_at <=?',5.day.ago).count
        @fail7=@question.performances.where(responsetime: -1 ).where('created_at >=?',7.day.ago).where('created_at <=?',6.day.ago).count

       # @status1=((@success1-@fail1)/@success1)*100
       # @status2=((@success2-@fail2)/@success2)*100
       # @status3=((@success3-@fail3)/@success3)*100
       # @status4=((@success4-@fail4)/@success4)*100
       # @status5=((@success5-@fail5)/@success5)*100
       # @status6=((@success6-@fail6)/@success6)*100
       # @status7=((@success7-@fail7)/@success7)*100

        #####################


        #####month###
        @monthsuccess=@question.performances.where('created_at >=?',4.week.ago).count
        @monthfail=@question.performances.where(responsetime: -1 ).where('created_at >=?',4.week.ago).count
        #@monthAvailability=((@monthsuccess-@monthfail)/@monthsuccess)*100

        ####yesterday####
        @yesterdayAV=@question.performances.where('created_at >=?',DateTime.yesterday.beginning_of_day).where('created_at <=?',DateTime.now.beginning_of_day).average(:responsetime)
        @yesterdayTotal=@question.performances.where('created_at >=?',DateTime.yesterday.beginning_of_day).where('created_at <=?',DateTime.now.beginning_of_day).count(:responsetime)
        @yesterdayFail=@question.performances.where(responsetime: -1 ).where('created_at >=?',DateTime.yesterday.beginning_of_day).where('created_at <=?',DateTime.now.beginning_of_day).count
       # @yesterdayAvai=((@yesterdayTotal-@yesterdayFail)/@yesterdayTotal)*100
        @yesterdayHigh=@question.performances.where('created_at >=?',DateTime.yesterday.beginning_of_day).where('created_at <=?',DateTime.now.beginning_of_day).maximum(:responsetime)
        @yesterdayLow=@question.performances.where('created_at >=?',DateTime.yesterday.beginning_of_day).where('created_at <=?',DateTime.now.beginning_of_day).minimum(:responsetime)
        
        ####pastweek####
        @pastweekAV=@question.performances.where('created_at >=?',14.day.ago).where('created_at <=?',6.day.ago).average(:responsetime)
        @pastTotal=@question.performances.where('created_at >=?',14.day.ago).where('created_at <=?',6.day.ago).count
        @pastFail=@question.performances.where(responsetime: -1 ).where('created_at >=?',14.day.ago).where('created_at <=?',6.day.ago).count
        #@pastAvai=((@pastTotal-@pastFail)/@pastTotal)*100
        @pastHigh=@question.performances.where('created_at >=?',14.day.ago).where('created_at <=?',6.day.ago).maximum(:responsetime)
        @pastLow=@question.performances.where('created_at >=?',14.day.ago).where('created_at <=?',6.day.ago).minimum(:responsetime)
  
        ###today### 

       @todayTotal=@question.performances.where('created_at >=?',DateTime.now.beginning_of_day).count
       @todayAV=@question.performances.where('created_at >=?',DateTime.now.beginning_of_day).average(:responsetime)
       @todayHigh=@question.performances.where('created_at >=?',DateTime.now.beginning_of_day).maximum(:responsetime)
       @todayLow=@question.performances.where('created_at >=?',DateTime.now.beginning_of_day).minimum(:responsetime)
       @todayFail=@question.performances.where(responsetime: -1 ).where('created_at >=?',DateTime.now.beginning_of_day).count
       @todayAvai=((@todayTotal-@todayFail)/@todayTotal)*100

       ###pastmonth##
       @pastmonthTotal=@question.performances.group_by_week(:created_at, time_zone: "Kuala Lumpur").where('created_at <=?',30.day.ago).where('created_at >=?',60.day.ago).count
       @pastmonthFail=@question.performances.group_by_week(:created_at, time_zone: "Kuala Lumpur").where(responsetime: -1 ).where('created_at <=?',30.day.ago).where('created_at >=?',60.day.ago).count
       #@pastmonthAvai=((@pastmonthTotal-@pastmonthFail)/@pastmonthTotal)*100
  end

  # GET /performances/1
  # GET /performances/1.json
  def show
    @question = Question.find(params[:question_id])
  end

  # GET /performances/new
  def new
    @performance = Performance.new
    @question = Question.find(params[:question_id])
  end

  # GET /performances/1/edit
  def edit
  end

  # POST /performances
  # POST /performances.json
  def create
   


   

    
    respond_to do |format|
      if @performance.save
        
        format.html { redirect_to question_performance_path(@question,@performance), notice: 'Performance was successfully created.' }
        format.json { render :show, status: :created, location: @performance }
      else
        format.html { render :new }
        format.json { render json: @performance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /performances/1
  # PATCH/PUT /performances/1.json
  def update
    respond_to do |format|
      if @performance.update(performance_params)
        format.html { redirect_to @performance, notice: 'Performance was successfully updated.' }
        format.json { render :show, status: :ok, location: @performance }
      else
        format.html { render :edit }
        format.json { render json: @performance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /performances/1
  # DELETE /performances/1.json
  def destroy
    @performance.destroy
    respond_to do |format|
      format.html { redirect_to performances_url, notice: 'Performance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_performance
      @performance = Performance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def performance_params
      params.require(:performance).permit(:responsetime)
    end
end
