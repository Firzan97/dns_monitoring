class Question < ApplicationRecord
has_many :performances , dependent: :destroy
has_one :detail , dependent: :destroy
has_many :choices , dependent: :destroy

belongs_to :user  
has_many :answers , dependent: :destroy

belongs_to :user


 TIMEPERIOD = 
 [
    ["1 Minute", 1],
    ["5 Minutes", 5],
    ["10 Minutes",10],
    ["30 Minutes",30],
    ["1 Hour",60],
    ["1 day",1440]
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

  def self.query(id)
    %x[cd dns6]
    %x[whenever --update-crontab]
    question=Question.find(id)
    namedns=question.dnsname
    type=question.recordtype
    server=question.server


    value1 = %x[ dig @#{server} #{namedns} #{type} | grep "Query time:" ]
    
    a,b=value1.split(":")
    num1,num2=b.split(" ")
    
    
    @performance = Performance.create(responsetime: num1.to_i,question_id: id)
 
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
  
    #a=12
    
    #value2 = %x[ dig @#{server} #{namedns} #{type} | sed -n #{a}'p' ]
     #   b,c,d,e,f=value2.split("")
     #   dnsanswer=b
     # while dnsanswer== namedns 
     #   value2 = %x[ dig @#{server} #{namedns} #{type} ]
     #   b,c,d,e,f=value2.split(" ")
     #   dnsanswer=b
     #   ttl=c
     #   t=d
     #   recordtype=e
     #   ip=f
     #   @a=Answer.create(dnsname: dnsanswer,ttl: ttl,recordtype: recordtype,ipaddress: ip)
     #   a=a+1
     # end
    
    %x[cd]
   end


end
