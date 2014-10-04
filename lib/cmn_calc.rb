# -*- encoding: utf-8 -*-
module CmnCalc

  #休憩
  #○　勤務時間が６時間を越えると４５分の休憩
  #　　勤務時間が８時間を越えると６０分の休憩
  #　　・休憩時間は１２：００～
  #　　・１２：００を過ぎて出勤した場合は出勤時間の３時間後から休憩時間とする
  #○  勤務時間が８時間を越えて時間外労働する場合は３０分
  KYUKEI_60M = 60        #勤務時間が８時間を越える休憩時間
  KYUKEI_45M = 45        #勤務時間が６時間を越える休憩時間
  KYUKEI_30M = 30        #時間外勤務の休憩時間

  HIRU_S = 1200  #昼休憩開始時間
  HIRU_E = 1300  #昼休憩終了時間
  TKYUKEI_S = 3      #出勤時間の３時間後から休憩
  KINMU_6H = 6       #勤務時間が６時間を越えると休憩
  KINMU_8H = 8       #勤務時間が８時間を越えると休憩
  ZANGYO_3_5H = 3.5    #勤務時間が更に３．５時間を越えると休憩
  ZANGYO_6_5H = 6.5    #勤務時間が更に６．５時間を越えると休憩
  ZANGYO_3H = 3      #勤務時間が更に３．０時間を越えると休憩

  SUNDAY = 1         #日曜日
  SATURDAY = 7       #土曜日
  HOLIDAY = 9        #休日

  #深夜時間
  SINYA_S = 2200  #ＰＭ１０：００
  SINYA_E = 2900  #ＡＭ０５：００
  SINYA_T = 500   #ＡＭ０５：００

  HOUR = 3600
  MIN  = 60
  #----------------------------------------------------------------------------
  # === メソッド概要
  #  （関数）勤務時間計算
  #----------------------------------------------------------------------------
  def calc_time(start_time, end_time)
      return calc(1, start_time, end_time)
  end
  #----------------------------------------------------------------------------
  # === メソッド概要
  #  （関数）勤務時間計算
  #----------------------------------------------------------------------------
  def calc_over_time(start_time, end_time)
      return calc(2, start_time, end_time)
  end
  #----------------------------------------------------------------------------
  # === メソッド概要
  #  （関数）勤務時間計算
  #----------------------------------------------------------------------------
  def calc_midnight_time(start_time, end_time)
      return calc(3, start_time, end_time)
  end
  #----------------------------------------------------------------------------
  # === メソッド概要
  #  （関数）勤務時間計算
  #----------------------------------------------------------------------------
  def calc(kbn, start_time, end_time)

    logger = Logger.new("c:/temp/test.log")


    #*** 初期値設定 ***
    kinmu_time = 0            # 勤務時間
    zangyo_time = 0           # 残業時間
    sinya_time = 0            # 深夜時間
    sinya_start_time = 0      # 残業開始時間
    sinya_end_time = 0        # 残業終了時間
    
    #勤務時間
    kinmu_time = end_time - start_time

    #休憩判定
    kyukei_time = 0
    if kinmu_time > 8 * HOUR      #８時間を越える
       kyukei_time = 60 * MIN
    elsif kinmu_time > 6 * HOUR   #６時間を越える
       kyukei_time = 45 * MIN
    end
    if kyukei_time > 0 
    end
    
    
    #時間外労働前休憩判定
    #８時間経過後３０分休憩
    if kinmu_time > 9*HOUR
      zangyo_start_time = start_time + 9*HOUR+30*MIN

     kyukei_start_time = start_time + 9*HOUR
     kyukei_end_time   = start_time + 9*HOUR+30*MIN

    logger.debug '---------------1----------------------'
    logger.debug kyukei_start_time
    logger.debug kyukei_end_time
    logger.debug '---------------1----------------------'

      if kinmu_time > 9*HOUR+30*MIN
        kyukei_time += 30*MIN
      end
    end
    
    #１１．５時間経過後３０分休憩
    if kinmu_time > 12*HOUR+30*MIN
 

     kyukei_start_time = start_time + 12*HOUR+30*MIN
     kyukei_end_time   = start_time + 13*HOUR

    logger.debug '---------------2----------------------'
    logger.debug kyukei_start_time
    logger.debug kyukei_end_time
    logger.debug '---------------2----------------------'

 

     if kinmu_time > (11*HOUR+30*MIN)+30*MIN
        kyukei_time += 30*MIN

    logger.debug '---------------2----------------------'

      end
    end

    #１８．０時間経過後３０分休憩
    if kinmu_time > 18*HOUR
 

     kyukei_start_time = start_time + 18*HOUR
     kyukei_end_time   = start_time + 18*HOUR+30*MIN

    logger.debug '---------------3----------------------'
    logger.debug kyukei_start_time
    logger.debug kyukei_end_time
    logger.debug '---------------3----------------------'

 
     if kinmu_time > 18*HOUR+30*MIN
        kyukei_time += 30*MIN

    logger.debug '---------------3----------------------'

      end
    end
    
    #２１．０時間経過後３０分休憩
    if kinmu_time > 21*HOUR
      if kinmu_time > 21*HOUR+30*MIN
        kyukei_time += 30*MIN

    logger.debug '---------------4----------------------'

      end
    end
    
    #深夜勤務判定
    if end_time > get_sinya_start_time(start_time)
       sinya_start_time = get_sinya_start_time(start_time)
       if sinya_start_time < end_time
          sinya_end_time = end_time
       end
    end


    logger.debug '---------------start----------------------'
    logger.debug start_time
    logger.debug '--------------- end ----------------------'
    logger.debug end_time
    #勤務時間(３０分単位で計算)
    #p '---------------kinmu---------------------'
    #p (get_min(kinmu_time)).to_s
    logger.debug '---------------kyukei---------------------'
    logger.debug (get_min2(kyukei_time))
    logger.debug '---------------kinmu---------------------'
    #p (get_min(kinmu_time - kyukei_time))
    logger.debug (get_min2(kinmu_time - kyukei_time))
    
    #残業時間(３０分単位で計算)
    logger.debug '---------------zangyo--------------------'
    #p (get_min(kinmu_time - kyukei_time - 8*HOUR))
    logger.debug (get_min2(kinmu_time - kyukei_time - 8*HOUR))

    #深夜時間(３０分単位で計算)
    logger.debug '----------------sinya--------------------'
    #p (get_min(sinya_end_time - sinya_start_time))
    logger.debug (get_min2(sinya_end_time - sinya_start_time))
    logger.debug '-----------------------------------------'


    if kbn == 1
      return get_min2(kinmu_time - kyukei_time)
    elsif kbn == 2
      return  get_min2(kinmu_time - kyukei_time - 8*HOUR)
    elsif kbn == 3
      return  get_min2(sinya_end_time - sinya_start_time)
    end
=begin
    strMsg = ""
    Select Case ActiveSheet.Cells(pRow, 1)
      Case SUNDAY, SATURDAY, HOLIDAY
        if kinmu_time <> 0 
           if zangyo_time <> 0 
              strMsg = "休日勤務でかつ残業が発生しています。"
           else
              strMsg = "休日勤務です。"
           end
        end
      Case else
        if zangyo_time > 0 
           strMsg = "残業が生じています。"
        end
    End Select
    
    strValue = objG_wJiyu.Cells(pRow, 10).Value
    if Len(strMsg) > 0 && Len(Trim(strValue)) = 0 
       Call MsgBox(strMsg & Chr(13) & Chr(13) & "時間外作業報告書に理由を記入してください！", vbOKOnly + vbExclamation, TITLE)
    end
    
    #####Debug.Print "***08 ANS:" & strAns
    ug_TIME = CStr(strAns)
=end
  end

  #　日を返します
  def get_days(time)
    days  = time.divmod(24*HOUR)
    return days[0]
  end
  #　時間を返します
  def get_hour(time)
    hours  = time.divmod(HOUR)
    return hours[0]
  end
  #　分を返します
  def get_min(time)
    mins  = time.divmod(MIN)
    return mins[0]
  end
  def get_sinya_start_time(time)
    end_time = Time.mktime(time.year, time.month, time.day, 22, 0, 0)
  end
  def get_times(time)
    days  = time.divmod(24*HOUR) #=> [2.0, 45000.0]
    hours = days[1].divmod(HOUR) #=> [12.0, 1800.0]
    mins  = hours[1].divmod(MIN) #=> [30.0, 0.0]
    return days, hours, mins
  end

  #　分を返します（時間＊１０＋０．５単位の分）
  def get_min2(time)
    hours = time.divmod(HOUR)
    mins  = hours[1].divmod(MIN)
=begin
p '============================================'
p  hours[0]
p  mins[0]
p  mins[0]/30*5
p  (hours[0]*10 + mins[0]/30*5).to_i
p '============================================'
=end
    return (hours[0]*10 + mins[0]/30*5)/10.to_f
  end


=begin
  #　日を返します
  def get_days(time)
    days  = time.divmod(24*HOUR) #=> [2.0, 45000.0]
    hours = days[1].divmod(HOUR) #=> [12.0, 1800.0]
    mins  = hours[1].divmod(MIN) #=> [30.0, 0.0]
    return days
  end
  #　時間を返します
  def get_hour(time)
    days  = time.divmod(24*HOUR) #=> [2.0, 45000.0]
    hours = days[1].divmod(HOUR) #=> [12.0, 1800.0]
    mins  = hours[1].divmod(MIN) #=> [30.0, 0.0]
    return hour
  end
  #　分を返します
  def get_min(time)
    days  = time.divmod(24*HOUR) #=> [2.0, 45000.0]
    hours = days[1].divmod(HOUR) #=> [12.0, 1800.0]
    mins  = hours[1].divmod(MIN) #=> [30.0, 0.0]
    return mins
  end
=end
=begin
  now_time = Time.now

  #開始時間
  start_time = Time.mktime(now_time.year, now_time.month, now_time.day, 9, 0)
  #終了時間
  end_time = Time.mktime(now_time.year, now_time.month, now_time.day, 18, 30)

  cal = Calc4.new
  cal.calc_time(start_time, end_time)
=end

  module_function :calc_time
  module_function :calc_over_time
  module_function :calc_midnight_time
  module_function :calc
  module_function :get_days
  module_function :get_hour
  module_function :get_min
  module_function :get_sinya_start_time
  module_function :get_times
  module_function :get_min2

end
