#このコードをコピペしてrubyファイルに貼り付け、そのファイルをirbでrequireして実行しましょう。

# 例

# irb
# require '/Users/shibatadaiki/work_shiba/full_stack/sample.rb'
# （↑のパスは、自動販売機ファイルが入っているパスを指定する）

# 初期設定（自動販売機インスタンスを作成して、vmという変数に代入する）
# vm = VendingMachine.new

# 作成した自動販売機に100円を入れる
# vm.slot_money (100)

# 作成した自動販売機に入れたお金がいくらかを確認する（表示する）
# vm.current_slot_money

# 作成した自動販売機に入れたお金を返してもらう
# vm.return_money

class VendingMachine
  # ステップ０　お金の投入と払い戻しの例コード
  # ステップ１　扱えないお金の例コード

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  MONEY = [10, 50, 100, 500, 1000].freeze

  # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
  def initialize
    # 最初の自動販売機に入っている金額は0円
    @slot_money = 0
    @stock_juice = { cola: {price:120,stock:5}, redbull: {price:200, stock:5}, water: {price:100,stock:5 }}
    @sales = 0
  end

  # 投入金額の総計を取得できる。
  def current_slot_money
    # 自動販売機に入っているお金を表示する
    @slot_money
  end

  def current_stock_juice
    # 自動販売機に入っているジュースを表示する
    @stock_juice
  end

  def current_sales
    # 自動販売機の売り上げを表示する
    @sales
  end

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def slot_money(money)
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    return money unless MONEY.include?(money)
    # MONEY.include?(money) ? nil.tap { @slot_money += money } : money
    # 自動販売機にお金を入れる
    @slot_money += money
  end
  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  def return_money
    # 返すお金の金額を表示する
    puts @slot_money
    # 自動販売機に入っているお金を0円に戻す
    @slot_money = 0
  end

  def can_buy_cola
    # 在庫のコーラが１以上かつ所持金が120円以上の場合はtrueそれ以外はfalse
    if @slot_money >= 120 && @stock_juice[:cola][:stock] >= 1
      @can = true
    else
      @can = false
    end
  end

  def buy_cola
    # 在庫のコーラが１以上かつ所持金が120円以上の場合はtrueそれ以外はfalse
    if @slot_money >= 120 && @stock_juice[:cola][:stock] >= 1
      @slot_money -= 120
      @stock_juice[:cola][:stock] -= 1
      @sales += 120
      "colaを購入しました。お釣りは#{@slot_money}円です。"
    else
      @slot_money
      @stock_juice[:cola][:stock]
      @sales
      "colaを購入できません"
    end
  end

  def can_buy_redbull
  # 在庫のコーラが１以上かつ所持金が120円以上の場合はtrueそれ以外はfalse
    if @slot_money >= 200 && @stock_juice[:redbull][:stock] >= 1
      @can = true
    else
      @can = false
    end
  end

  def buy_redbull
  # 在庫のコーラが１以上かつ所持金が120円以上の場合はtrueそれ以外はfalse
    if @slot_money >= 200 && @stock_juice[:redbull][:stock] >= 1
      @slot_money -= 200
      @stock_juice[:redbull][:stock] -= 1
      @sales += 200
      "redbullを購入しましたyo。お釣りは#{@slot_money}円です。"
    else
      @slot_money
      @stock_juice[:redbull][:stock]
      @sales
      "redbullを購入できませんyo"
    end
  end

  def can_buy_water
  # 在庫のコーラが１以上かつ所持金が120円以上の場合はtrueそれ以外はfalse
    if @slot_money >= 100 && @stock_juice[:water][:stock] >= 1
      @can = true
    else
      @can = false
    end
  end

  def buy_water
  # 在庫のコーラが１以上かつ所持金が120円以上の場合はtrueそれ以外はfalse
    if @slot_money >= 100 && @stock_juice[:water][:stock] >= 1
      @slot_money -= 100
      @stock_juice[:water][:stock] -= 1
      @sales += 100
      "waterを購入しました。お釣りは#{@slot_money}円です。"
    else
      @slot_money
      @stock_juice[:water][:stock]
      @sales
      "waterを購入できません"
    end
  end
  #購入可能なドリンクの種類の名前を取得する。
  def purchasable?(drink_name)
    purchasable_drink_names.include? drink_name
  end

  def purchasable_drink_names
    @stock_juice.select{|_, info| info[:price] <= @slot_money && info[:stock] > 0 }.keys
  end

end
