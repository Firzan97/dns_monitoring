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
        @success2=@question.performances.where('created_at >=?',1.day.ago).where('created_at <=?',1.day.ago).count
        @success3=@question.performances.where('created_at >=?',2.day.ago).where('created_at <=?',2.day.ago).count
        @success4=@question.performances.where('created_at >=?',3.day.ago).where('created_at <=?',3.day.ago).count
        @success5=@question.performances.where('created_at >=?',4.day.ago).where('created_at <=?',4.day.ago).count
        @success6=@question.performances.where('created_at >=?',5.day.ago).where('created_at <=?',5.day.ago).count
        @success7=@question.performances.where('created_at >=?',6.day.ago).where('created_at <=?',6.day.ago).count
        @weeksuccess=@question.performances.where('created_at >=?',7.day.ago).count
        @weekfail=@question.performances.where(responsetime: -1 ).where('created_at >=?',7.day.ago).count
        @weekAvailability=((@weeksuccess-@weekfail)/@weeksuccess)*100
        @success8=@question.performances.where('created_at >=?',1.week.ago).count
        @success9=@question.performances.where('created_at >=?',2.week.ago).where('created_at <=?',1.week.ago).count
        @success10=@question.performances.where('created_at >=?',3.week.ago).where('created_at <=?',2.week.ago).count
        @success11=@question.performances.where('created_at >=?',4.week.ago).where('created_at <=?',3.week.ago).count


        @fail1=@question.performances.where(responsetime: -1 ).where('created_at >=?',DateTime.now.beginning_of_day).count
        @fail2=@question.performances.where(responsetime: -1 ).where('created_at >=?',1.day.ago).where('created_at <=?',1.day.ago).count
        @fail3=@question.performances.where(responsetime: -1 ).where('created_at >=?',2.day.ago).where('created_at <=?',2.day.ago).count
        @fail4=@question.performances.where(responsetime: -1 ).where('created_at >=?',3.day.ago).where('created_at <=?',3.day.ago).count
        @fail5=@question.performances.where(responsetime: -1 ).where('created_at >=?',4.day.ago).where('created_at <=?',4.day.ago).count
        @fail6=@question.performances.where(responsetime: -1 ).where('created_at >=?',5.day.ago).where('created_at <=?',5.day.ago).count
        @fail7=@question.performances.where(responsetime: -1 ).where('created_at >=?',6.day.ago).where('created_at <=?',6.day.ago).count
        @fail8=@question.performances.where(responsetime: -1 ).where('created_at >=?',1.week.ago).count
        @fail9=@question.performances.where(responsetime: -1 ).where('created_at >=?',2.week.ago).where('created_at <=?',1.week.ago).count
        @fail10=@question.performances.where(responsetime: -1 ).where('created_at >=?',3.week.ago).where('created_at <=?',2.week.ago).count
        @fail11=@question.performances.where(responsetime: -1 ).where('created_at >=?',4.week.ago).where('created_at <=?',3.week.ago).count



        if @success1==0
          @status1=0
         
        else
          
          @status1=((@success1-@fail1)/@success1)*100
        end

        if @success2==0
         @status2=0
        else
          @status2=((@success2-@fail2)/@success2)*100
        end

        if @success3==0
         @status3=0
        else
          @status3=((@success3-@fail3)/@success3)*100
        end

        if @success4==0
         @status4=0
        else
          @status4=((@success4-@fail4)/@success4)*100
        end

        if @success5==0
         @status5=0
        else
          @status5=((@success5-@fail5)/@success5)*100
        end

        if @success6==0
         @status6=0
        else
          @status6=((@success6-@fail6)/@success6)*100
        end

        if @success7==0
         @status7=0
        else
          @status7=((@success7-@fail7)/@success7)*100
        end

        if @success8==0
         @status8=0
        else
          @status8=((@success8-@fail8)/@success8)*100
        end

        if @success9==0
         @status9=0
        else
          @status9=((@success9-@fail9)/@success9)*100
        end

        if @success10==0
         @status10=0
        else
          @status10=((@success10-@fail10)/@success10)*100
        end

        if @success11==0
         @status11=0
        else
          @status11=((@success11-@fail11)/@success11)*100
        end

        #####################


        #####month###
        @monthsuccess=@question.performances.where('created_at >=?',4.week.ago).count
        @monthfail=@question.performances.where(responsetime: -1 ).where('created_at >=?',4.week.ago).count
        #@monthAvailability=((@monthsuccess-@monthfail)/@monthsuccess)*100

        ####yesterday####
        @yesterdayAV=@question.performances.where('created_at >=?',DateTime.yesterday.beginning_of_day).where('created_at <=?',DateTime.now.beginning_of_day).average(:responsetime)
        if @yesterdayAV==nil
          @yesterdayAV=0
        end

        @yesterdayTotal=@question.performances.where('created_at >=?',DateTime.yesterday.beginning_of_day).where('created_at <=?',DateTime.now.beginning_of_day).count(:responsetime)
         if @yesterdayTotal==nil
          @yesterdayTotal=0
        end

        @yesterdayFail=@question.performances.where(responsetime: -1 ).where('created_at >=?',DateTime.yesterday.beginning_of_day).where('created_at <=?',DateTime.now.beginning_of_day).count
         if @yesterdayAV==nil
          @yesterdayAV=0
        end

        if @yesterdayTotal==0
          @yesterdayAvai=0
        else
           @yesterdayAvai=((@yesterdayTotal-@yesterdayFail)/@yesterdayTotal)*100
         end

        @yesterdayHigh=@question.performances.where('created_at >=?',DateTime.yesterday.beginning_of_day).where('created_at <=?',DateTime.now.beginning_of_day).maximum(:responsetime)
         if @yesterdayHigh==nil
          @yesterdayHigh=0
        end

        @yesterdayLow=@question.performances.where('created_at >=?',DateTime.yesterday.beginning_of_day).where('created_at <=?',DateTime.now.beginning_of_day).minimum(:responsetime)
         if @yesterdayLow==nil
          @yesterdayLow=0
        end
        ####pastweek####
        @pastweekAV=@question.performances.where('created_at >=?',14.day.ago).where('created_at <=?',6.day.ago).average(:responsetime)
        if @pastweekAV==nil
          @pastweekAV=0
        end

        @pastTotal=@question.performances.where('created_at >=?',14.day.ago).where('created_at <=?',6.day.ago).count

        @pastFail=@question.performances.where(responsetime: -1 ).where('created_at >=?',14.day.ago).where('created_at <=?',6.day.ago).count
        
        if @pastTotal==0
           @pastAvai=0
         else
          @pastAvai=((@pastTotal-@pastFail)/@pastTotal)*100
        end
        
        @pastHigh=@question.performances.where('created_at >=?',14.day.ago).where('created_at <=?',6.day.ago).maximum(:responsetime)
        if @pastHigh==nil
          @pastHigh=0
        end

        @pastLow=@question.performances.where('created_at >=?',14.day.ago).where('created_at <=?',6.day.ago).minimum(:responsetime)
        if @pastLow==nil
          @pastLow=0
        end
        ###today### 

       @todayTotal=@question.performances.where('created_at >=?',DateTime.now.beginning_of_day).count
       @todayAV=@question.performances.where('created_at >=?',DateTime.now.beginning_of_day).average(:responsetime)
       @todayHigh=@question.performances.where('created_at >=?',DateTime.now.beginning_of_day).maximum(:responsetime)
       @todayLow=@question.performances.where('created_at >=?',DateTime.now.beginning_of_day).minimum(:responsetime)
       @todayFail=@question.performances.where(responsetime: -1 ).where('created_at >=?',DateTime.now.beginning_of_day).count
       if @todayTotal==0
        @todayAvai=0
       else
       @todayAvai=((@todayTotal-@todayFail)/@todayTotal)*100
       end

       ###pastmonth##
       @pastmonthTotal=@question.performances.where('created_at <=?',30.day.ago).where('created_at >=?',60.day.ago).count
       @pastmonthFail=@question.performances.where(responsetime: -1 ).where('created_at <=?',30.day.ago).where('created_at >=?',60.day.ago).count
       
       if @pastmonthTotal==0
        @pastmonthAvai=0
      else
         @pastmonthAvai=((@pastmonthTotal-@pastmonthFail)/@pastmonthTotal)*100
       end
       
       @pastmonthHigh=@question.performances.where('created_at <=?',30.day.ago).where('created_at >=?',60.day.ago).maximum(:responsetime)
       if @pastmonthHigh==nil
          @pastmonthHigh=0
        end

       @pastmonthLow=@question.performances.where('created_at <=?',30.day.ago).where('created_at >=?',60.day.ago).minimum(:responsetime)
       if @pastmonthLow==nil
          @pastmonthLow=0
        end

       @pastmonthAV=@question.performances.where('created_at <=?',30.day.ago).where('created_at >=?',60.day.ago).average(:responsetime)
        if @pastmonthAV==nil
          @pastmonthAV=0
        end

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
