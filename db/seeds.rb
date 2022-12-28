#筋トレ部位のデータ
body_part_names = [ "胸", "肩", "背中", "腕", "脚"]
body_part_names.each do |body_part_name|
  BodyPart.create!(body_part_name: body_part_name)
end

#環境別のseedファイル読み込み
load(Rails.root.join("db", "seeds", "#{Rails.env.downcase}.rb"))
