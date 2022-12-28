#環境別のseedファイル読み込み
load(Rails.root.join("db", "seeds", "#{Rails.env.downcase}.rb"))
