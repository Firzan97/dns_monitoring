class Question < ApplicationRecord

has_one :detail , dependent: :destroy
has_many :choices , dependent: :destroy
has_many :performances , :dependent => :delete_all
belongs_to :user  
has_many :changelogs , dependent: :destroy
has_many :answers , dependent: :destroy
after_save :update_whenever



 TIMEPERIOD = 
 [
    ["1 Minute", 1],
    ["5 Minutes", 5],
    ["10 Minutes",10],
    ["30 Minutes",30],
    ["1 Hour",60]
 ]
  
    #value2 = %x[ dig @#{server} #{namedns} #{type} ]
    #a=15
    #while value2!=namedns
    #{
    #    value2 = %x[ dig @#{server} #{namedns} #{type} | sed -n '#{a}p' ]
    #    b,c,d,e,f=value2.split("")
    #    dnsanswer=b
    #    l=c
    #    t=d
    #    o=e
    #    s=f
    #    a++
    #} 

def self.search(search1,search2,search3)
  if search1 && search2 && search3
    self.where("dnsname like ?", "%#{search1}%").where("recordtype like ?", "%#{search2}%").where("server like ?", "%#{search3}%")
  else
    self.all
  end
end


    def update_whenever
      Rails.logger.debug"Whenever Started"
      %x[whenever --update-crontab]
    end

  def self.query(id)

    
    question=Question.find(id)
    namedns=question.dnsname
    type=question.recordtype
    server=question.server


    value1 = %x[ dig @#{server} #{namedns} #{type} | grep "Query time:" ]
    
    a,b=value1.split(":")
    num1,num2=b.split(" ")
    
    
    @performance = Performance.create(responsetime: num1.to_i,question_id: id)
    a=@performance.created_at.in_time_zone('Kuala Lumpur')
    @performance.update(responsetime: num1.to_i,question_id: id,date_malay: a)
    #question.update(created_at:)
    average=Performance.where(question_id: question.id).average(:responsetime)
    highest=Performance.where(question_id: question.id).maximum(:responsetime)
    lowest=Performance.where(question_id: question.id).minimum(:responsetime)
    count=Performance.where(question_id: question.id).count(:responsetime)
    unavailable=Performance.where(responsetime: -1 )
    a=unavailable.where(question_id: question.id).count(:responsetime)
    availability=((count.to_f-a.to_f)/count.to_f)*100
 
    
    detail=Detail.where(question_id:id)
    detail.update(average: average.round(2),maximum: highest,minimum: lowest,total_query: count,total_fail: a ,status: availability.round(2) )
    
    
    %x[cd]

     total=%x[ dig @#{server} #{namedns} #{type} | wc -l ]
     total1,total2=total.split("\n") 
     
     while a != total1.to_i
      
      value2 =%x[ dig @#{server} #{namedns} #{type} | sed -n '#{a}p' ]
         
         if value2==";; ANSWER SECTION:\n"
                   
           a=a+1
           value2 =%x[ dig @#{server} #{namedns} #{type} | sed -n '#{a}p' ]
           answerList=question.answers.where(typeAnswer: "answer")
           a1=0
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
             answerType="answer" 
             
            
            if answerList[a1].ipaddress != ip
             Changelog.create(dnsname: answerList[a1].ipaddress,ipaddress: ip,question_id: id,typeanswer: answerType)
             #Answer.update(ipaddress: ip)
            end
            
             a=a+1      
             value2 =%x[ dig @#{server} #{namedns} #{type} | sed -n '#{a}p' ] 
             a1=a1+1;
           
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
            if answerList[a1].ipaddress != ip
             Changelog.create(dnsname: dnsanswer,ipaddress: ip,question_id: id,typeanswer: answerType)
             #Answer.update(ipaddress: ip)
            end
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
             if answerList[a1].ipaddress != ip
              Changelog.create(dnsname: dnsanswer,ipaddress: ip,question_id: id,typeanswer: answerType)
              #Answer.update(ipaddress: ip)
             end
             a=a+1      
             value2 =%x[ dig @#{server} #{namedns} #{type} | sed -n '#{a}p' ] 
           end
         end

     
     
     a =a+1
   end










   end


end
