class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!, except: [:index,:show]

  # GET /questions
  # GET /questions.json
  def index
    @questions = current_user.questions.search(params[:search1],params[:search2],params[:search3]) 
    @performance=Performance.all
  

  end
   def home
    @question = Question.all
    @performance=Performance.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @questions = Question.find(params[:id])
    @answers = @question.answers.all
  end

  # GET /questions/new
  def new
    @question = current_user.questions.build
  
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = current_user.questions.new(question_params)
    namedns=@question.dnsname
    type=@question.recordtype
    server=@question.server
    time=@question.timeperiod
    testing = %x[ dig #{namedns} #{type} | grep "SERVER:" ]
    c,d=testing.split(": ")
    e,f=d.split("#")
    if e != "127.0.0.1"
    
    if server==""
      value2 = %x[ dig #{namedns} #{type} | grep "SERVER:" ]
      c,d=value2.split(": ")  
      e,f=d.split("#")
    query1=%x[dig #{namedns} #{type} | grep "QUERY:"]
    q1,q2,q3,q4=query1.split(",")
    q5,q6,q66=q1.split(": ")
    q7,q8=q2.split(": ")
    q9,q10=q3.split(": ")
    q11,q12=q4.split(": ")
    query2=query1=%x[dig #{namedns} #{type} | grep "version:"]
    q21,q22=query2.split(",")
    q23,q24,q25=q21.split(": ")
    q26,q27,q28=q22.split(": ")
    else
    value2 = %x[ dig @#{server} #{namedns} #{type} | grep "SERVER:" ]
      c,d=value2.split(": ")
      e,f=d.split("#")
    query1=%x[dig @#{server} #{namedns} #{type} | grep "QUERY:"]
    q1,q2,q3,q4=query1.split(",")
    q5,q6,q66=q1.split(": ")
    q7,q8=q2.split(": ")
    q9,q10=q3.split(": ")
    q11,q12=q4.split(": ")
    query2=query1=%x[dig @#{server} #{namedns} #{type} | grep "version:"]
    q21,q22=query2.split(",")
    q23,q24,q25=q21.split(": ")
    q26,q27,q28=q22.split(": ")
    end
    end
    server=e
    
    if server.blank?
    @question=current_user.questions.create(dnsname:  namedns, recordtype:  type, server: server, timeperiod: time, query: q66, answer: q8, authority: q10, additional: q12, version: q25, udp: q27)
    else
    @question=current_user.questions.create(dnsname:  namedns, recordtype:  type, server: server, timeperiod: time, query: q66, answer: q8, authority: q10, additional: q12, version: q25, udp: q27)
    end
    
        
        @average=Performance.where(question_id: @question.id).average(:responsetime)
        @highest=Performance.where(question_id: @question.id).maximum(:responsetime)
        @lowest=Performance.where(question_id: @question.id).minimum(:responsetime)
        @count=Performance.where(question_id: @question.id).count(:responsetime)
        @unavailable=Performance.where(responsetime: -1 )
        @a=@unavailable.where(question_id: @question.id).count(:responsetime)
        @availability=0
     
        Search.create(server: @question.dnsname)
        
    
     total=%x[ dig @#{server} #{namedns} #{type} | wc -l ]
     total1,total2=total.split("\n") 
    
     a = 1
     while a != total1.to_i
      
      value2 =%x[ dig @#{server} #{namedns} #{type} | sed -n '#{a}p' ]


         if value2==";; ANSWER SECTION:\n"
           a=a+1
           value2 =%x[ dig @#{server} #{namedns} #{type} | sed -n '#{a}p' ]
           while value2 !="\n"
#          
             
             b,c,d,e,f,g=value2.split(" ")
             dnsanswer=b 
             ttl=c 
             typeAnswer=e 
             o=e 
             if g != nil 
             ip=f+" "+g
             else 
             ip=f 
             end 
             answerType="answer" 
             #answerList=Answer.question.where(:typeAnswer "answer")
             #answerList.each do |f|
             #if f.ipadress != ip
              #Change.create() 
             Answer.create(dnsname: dnsanswer,ttl: c,recordtype: e,ipaddress: ip,question_id: @question.id, typeAnswer: answerType)
             a=a+1      
             value2 =%x[ dig @#{server} #{namedns} #{type} | sed -n '#{a}p' ] 
           end
      end

        if value2==";; AUTHORITY SECTION:\n"
          
           a = a+1
           value2 =%x[ dig @#{server} #{namedns} #{type} | sed -n '#{a}p' ]
           while value2 != "\n"

           
            b,c,d,e,f,g=value2.split(" ")
            dnsanswer=b
            ttl=c
            typeAnswer=e
            o=e
            if g != nil
             ip=f+" "+g
             else
             ip=f
           end
            answerType="authority"
            Answer.create(dnsname: dnsanswer,ttl: c,recordtype:  typeAnswer,ipaddress: ip,question_id: @question.id, typeAnswer: answerType)
            a = a+1      
            value2 =%x[ dig @#{server} #{namedns} #{type} | sed -n '#{a}p' ] 
           end
       end
       
       if value2==";; ADDITIONAL SECTION:\n"
            a=a+1
            value2 =%x[ dig @#{server} #{namedns} #{type} | sed -n '#{a}p' ]
            while value2 !="\n"          
             b,c,d,e,f,g=value2.split(" ")
             dnsanswer=b
             ttl=c
             typeAnswer=e
             o=e
             if g != nil
             ip=f+" "+g
             else
             ip=f
             end
             answerType="additional"
             Answer.create(dnsname: dnsanswer,ttl: c,recordtype:  typeAnswer,ipaddress: ip,question_id: @question.id, typeAnswer: answerType)
             a=a+1      
             value2 =%x[ dig @#{server} #{namedns} #{type} | sed -n '#{a}p' ] 
           end
         end

     
     
     
     a =a+1
   end





    



  


    respond_to do |format|
      if @question.save
        @question.create_detail(:average => @average ,:maximum => @highest,:minimum => @lowest,:total_query => @count,:total_fail => @a ,:status =>@availability )

        
      
        format.html { redirect_to @question, notice: 'DNS was successfully Add.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'DNS was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy

    @question.destroy
    
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'DNS was successfully removed.' }
      format.json { head :no_content }
   
end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:dnsname, :recordtype, :server,:timeperiod)
    end
end
