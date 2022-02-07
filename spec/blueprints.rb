Sham.define do
  nombre { Faker::Name.name }
  cantidad_del_colores { 1..5 }
end

Diseno.blueprint do
  nombre_de_orden { Sham.nombre }
  cantidad_del_colores
end

Color.blueprint do
  nombre
  codigo { Sham.nombre }
end

Marca.blueprint do
  nombre
end