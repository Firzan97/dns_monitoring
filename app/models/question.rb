class Question < ApplicationRecord

has_one :detail , dependent: :destroy
has_many :choices , dependent: :destroy
has_many :performances , :dependent => :delete_all
belongs_to :user  
has_many :answers , dependent: :destroy
after_create :update_whenever
before_create :update_whenever2


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

 def update_whenever2
      Rails.logger.debug"Whenever Started"
      %x[whenever --update-crontab]
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
