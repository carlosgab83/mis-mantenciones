class ReplaceFncRvmHomoModeloGPostgresqlFunction < ActiveRecord::Migration[5.0]
  def up
    execute  "
      CREATE OR REPLACE FUNCTION public.fnc_rvm_homo_modelo_g(p_mar_id integer, p_modelo text)
        RETURNS integer AS
      $BODY$DECLARE
        c_mod record;
        v_mod_id integer;
               BEGIN
                    v_mod_id:=0;
                    -- Buscamos por aproximacion de palabra exacta....
                    if v_mod_id = 0 then
                        for c_mod in (select id_modelo, id_marca, modelo_descripcion, modelo_estado, mod_cantesp from v_vehiculo_modelo_cantidad
                         WHERE modelo_estado=1 AND id_marca= P_MAR_ID and trim(modelo_descripcion)= trim(P_MODELO) )
                        loop
                            v_mod_id:=c_mod.id_modelo;
                        end loop;
                    end if;
                    -- Buscamos por aproximacion de 3 palabras....
                    if v_mod_id = 0 then
                        for c_mod in (select id_modelo, id_marca, modelo_descripcion, modelo_estado, mod_cantesp from v_vehiculo_modelo_cantidad
                                        WHERE modelo_estado=1 AND id_marca= P_MAR_ID and
                                        modelo_descripcion like  concat(split_part(P_MODELO,' ',1), ' ', split_part(P_MODELO,' ',2), ' ', split_part(P_MODELO,' ',3)) ||'%' )
                        loop
                            v_mod_id:=c_mod.id_modelo;
                        end loop;
                    end if;

                    -- Buscamos por aproximacion de 2 palabras....
                    if v_mod_id = 0 then
                        for c_mod in (select id_modelo, id_marca, modelo_descripcion, modelo_estado, mod_cantesp from v_vehiculo_modelo_cantidad
                                        WHERE modelo_estado=1 AND id_marca= P_MAR_ID and
                                        modelo_descripcion like concat(split_part(P_MODELO,' ',1), ' ', split_part(P_MODELO,' ',2)) ||'%' )
                        loop
                            v_mod_id:=c_mod.id_modelo;
                        end loop;
                    end if;

                    -- Buscamos por aproximacion de 1 palabras....
                    if v_mod_id = 0 then
                        for c_mod in (select id_modelo, id_marca, modelo_descripcion, modelo_estado, mod_cantesp from v_vehiculo_modelo_cantidad
                                        WHERE modelo_estado=1 AND id_marca= P_MAR_ID and
                                       split_part(modelo_descripcion,' ',1) =  split_part(P_MODELO,' ',1) )
                        loop
                            v_mod_id:=c_mod.id_modelo;
                        end loop;
                    end if;

                    /*if v_mod_id = 0 then
                        for c_mod in (select id_modelo, id_marca, modelo_descripcion, modelo_estado, mod_cantesp from v_vehiculo_modelo_cantidad
                                        WHERE modelo_estado=1 AND id_marca= P_MAR_ID and
                                       left(modelo_descripcion ,1) =  genpro.am_split.EXT(P_MODELO,' ',1) || genpro.am_split.EXT(P_MODELO,' ',2))
                        loop
                            v_mod_id:=c_mod.mod_id;
                        end loop;
                    end if;

                    if v_mod_id = 0 then
                        for c_mod in (select mod_id, mar_id, mod_descripcion, mod_estado, mod_cantesp from genpol.v_vehiculo_modelo_cantidad
                                        WHERE mod_estado=0 AND mar_id= P_MAR_ID and
                                       genpro.am_split.EXT(mod_descripcion ,' ',1) || genpro.am_split.EXT(mod_descripcion ,' ',2)=  genpro.am_split.EXT(P_MODELO,' ',1))
                        loop
                            v_mod_id:=c_mod.mod_id;
                        end loop;
                    end if;

                    if v_mod_id = 0 then
                        for c_mod in (select mod_id, mar_id, mod_descripcion, mod_estado, mod_cantesp from genpol.v_vehiculo_modelo_cantidad
                                        WHERE mod_estado=0 AND mar_id= P_MAR_ID and
                                       (genpro.am_split.EXT(mod_descripcion ,' ',1) =  genpro.am_split.EXT(P_MODELO,' ',2) or genpro.am_split.EXT(mod_descripcion ,' ',2) =  genpro.am_split.EXT(P_MODELO,' ',1))  )
                        loop
                            v_mod_id:=c_mod.mod_id;
                        end loop;
                    end if;*/

                    -- buscamos por aproximacion fonetica....
                    if v_mod_id = 0 then
                        for c_mod in (select id_modelo, id_marca, modelo_descripcion, modelo_estado, mod_cantesp from v_vehiculo_modelo_cantidad
                                        WHERE modelo_estado=1 AND id_marca= P_MAR_ID and SOUNDEX (modelo_descripcion) =  SOUNDEX (P_MODELO))
                        loop
                            v_mod_id:=c_mod.id_modelo;
                        end loop;
                    end if;
                    -- si no se encontro usamos otra forma de aproximacion fonetica usando 3 palabras
                    if v_mod_id = 0 then
                        for c_mod in (select id_modelo, id_marca, modelo_descripcion, modelo_estado, mod_cantesp from v_vehiculo_modelo_cantidad
                                    WHERE modelo_estado=1 AND id_marca= P_MAR_ID and
                                        SOUNDEX (modelo_descripcion) =  SOUNDEX (concat(split_part(P_MODELO,' ',1), ' ', split_part(P_MODELO,' ',2), ' ', split_part(P_MODELO,' ',3))))
                        loop
                            v_mod_id:=c_mod.id_modelo;
                        end loop;
                    end if;
                    -- en caso contrario usamos con 2 palabras la fonetica
                    if v_mod_id = 0 then
                        for c_mod in (select id_modelo, id_marca, modelo_descripcion, modelo_estado, mod_cantesp from v_vehiculo_modelo_cantidad
                                    WHERE modelo_estado=1 AND id_marca= P_MAR_ID and
                                        SOUNDEX (modelo_descripcion) =  SOUNDEX (concat(split_part(P_MODELO,' ',1), ' ', split_part(P_MODELO,' ',2))))
                        loop
                            v_mod_id:=c_mod.id_modelo;
                        end loop;
                    end if;

                    -- la ultima opcion usamos 1 palabra en la fonetica
                    if v_mod_id = 0 then
                        for c_mod in (select id_modelo, id_marca, modelo_descripcion, modelo_estado, mod_cantesp from v_vehiculo_modelo_cantidad
                                    WHERE modelo_estado=1 AND id_marca= P_MAR_ID and
                                        SOUNDEX (modelo_descripcion) =  SOUNDEX (concat(split_part(P_MODELO,' ',1))))
                        loop
                            v_mod_id:=c_mod.id_modelo;
                        end loop;
                    end if;
                    --

                    RETURN v_mod_id;
              END;$BODY$
        LANGUAGE plpgsql VOLATILE
        COST 100;"
  end

  def down
    execute "
      CREATE OR REPLACE FUNCTION public.fnc_rvm_homo_modelo_g(p_mar_id integer, p_modelo text)
        RETURNS integer AS
      $BODY$DECLARE
        c_mod record;
        v_mod_id integer;
               BEGIN
                    v_mod_id:=0;
                    -- Buscamos por aproximacion de palabra exacta....
                    if v_mod_id = 0 then
                        for c_mod in (select id_modelo, id_marca, modelo_descripcion, modelo_estado, mod_cantesp from v_vehiculo_modelo_cantidad
                         WHERE modelo_estado=1 AND id_marca= P_MAR_ID and trim(modelo_descripcion)= trim(P_MODELO) )
                        loop
                            v_mod_id:=c_mod.id_modelo;
                        end loop;
                    end if;
                    -- Buscamos por aproximacion de 3 palabras....
                    if v_mod_id = 0 then
                        for c_mod in (select id_modelo, id_marca, modelo_descripcion, modelo_estado, mod_cantesp from v_vehiculo_modelo_cantidad
                                        WHERE modelo_estado=1 AND id_marca= P_MAR_ID and
                                        modelo_descripcion like  left(P_MODELO,3) ||'%' )
                        loop
                            v_mod_id:=c_mod.id_modelo;
                        end loop;
                    end if;

                    -- Buscamos por aproximacion de 2 palabras....
                    if v_mod_id = 0 then
                        for c_mod in (select id_modelo, id_marca, modelo_descripcion, modelo_estado, mod_cantesp from v_vehiculo_modelo_cantidad
                                        WHERE modelo_estado=1 AND id_marca= P_MAR_ID and
                                        modelo_descripcion like  left(P_MODELO,2) ||'%' )
                        loop
                            v_mod_id:=c_mod.id_modelo;
                        end loop;
                    end if;

                    -- Buscamos por aproximacion de 1 palabras....
                    if v_mod_id = 0 then
                        for c_mod in (select id_modelo, id_marca, modelo_descripcion, modelo_estado, mod_cantesp from v_vehiculo_modelo_cantidad
                                        WHERE modelo_estado=1 AND id_marca= P_MAR_ID and
                                       left(modelo_descripcion ,1) =  left(P_MODELO,1) )
                        loop
                            v_mod_id:=c_mod.id_modelo;
                        end loop;
                    end if;

                    /*if v_mod_id = 0 then
                        for c_mod in (select id_modelo, id_marca, modelo_descripcion, modelo_estado, mod_cantesp from v_vehiculo_modelo_cantidad
                                        WHERE modelo_estado=1 AND id_marca= P_MAR_ID and
                                       left(modelo_descripcion ,1) =  genpro.am_split.EXT(P_MODELO,' ',1) || genpro.am_split.EXT(P_MODELO,' ',2))
                        loop
                            v_mod_id:=c_mod.mod_id;
                        end loop;
                    end if;

                    if v_mod_id = 0 then
                        for c_mod in (select mod_id, mar_id, mod_descripcion, mod_estado, mod_cantesp from genpol.v_vehiculo_modelo_cantidad
                                        WHERE mod_estado=0 AND mar_id= P_MAR_ID and
                                       genpro.am_split.EXT(mod_descripcion ,' ',1) || genpro.am_split.EXT(mod_descripcion ,' ',2)=  genpro.am_split.EXT(P_MODELO,' ',1))
                        loop
                            v_mod_id:=c_mod.mod_id;
                        end loop;
                    end if;

                    if v_mod_id = 0 then
                        for c_mod in (select mod_id, mar_id, mod_descripcion, mod_estado, mod_cantesp from genpol.v_vehiculo_modelo_cantidad
                                        WHERE mod_estado=0 AND mar_id= P_MAR_ID and
                                       (genpro.am_split.EXT(mod_descripcion ,' ',1) =  genpro.am_split.EXT(P_MODELO,' ',2) or genpro.am_split.EXT(mod_descripcion ,' ',2) =  genpro.am_split.EXT(P_MODELO,' ',1))  )
                        loop
                            v_mod_id:=c_mod.mod_id;
                        end loop;
                    end if;*/

                    -- buscamos por aproximacion fonetica....
                    if v_mod_id = 0 then
                        for c_mod in (select id_modelo, id_marca, modelo_descripcion, modelo_estado, mod_cantesp from v_vehiculo_modelo_cantidad
                                        WHERE modelo_estado=1 AND id_marca= P_MAR_ID and SOUNDEX (modelo_descripcion) =  SOUNDEX (P_MODELO))
                        loop
                            v_mod_id:=c_mod.id_modelo;
                        end loop;
                    end if;
                    -- si no se encontro usamos otra forma de aproximacion fonetica usando 3 palabras
                    if v_mod_id = 0 then
                        for c_mod in (select id_modelo, id_marca, modelo_descripcion, modelo_estado, mod_cantesp from v_vehiculo_modelo_cantidad
                                    WHERE modelo_estado=1 AND id_marca= P_MAR_ID and
                                        SOUNDEX (left(modelo_descripcion,3)) =  SOUNDEX (left(P_MODELO,3)))
                        loop
                            v_mod_id:=c_mod.id_modelo;
                        end loop;
                    end if;
                    -- en caso contrario usamos con 2 palabras la fonetica
                    if v_mod_id = 0 then
                        for c_mod in (select id_modelo, id_marca, modelo_descripcion, modelo_estado, mod_cantesp from v_vehiculo_modelo_cantidad
                                    WHERE modelo_estado=1 AND id_marca= P_MAR_ID and
                                        SOUNDEX (left(modelo_descripcion,2)) =  SOUNDEX (left(P_MODELO,2)))
                        loop
                            v_mod_id:=c_mod.id_modelo;
                        end loop;
                    end if;

                    -- la ultima opcion usamos 1 palabra en la fonetica
                    if v_mod_id = 0 then
                        for c_mod in (select id_modelo, id_marca, modelo_descripcion, modelo_estado, mod_cantesp from v_vehiculo_modelo_cantidad
                                    WHERE modelo_estado=1 AND id_marca= P_MAR_ID and
                                        SOUNDEX (left(modelo_descripcion,1)) =  SOUNDEX (left(P_MODELO,1)))
                        loop
                            v_mod_id:=c_mod.id_modelo;
                        end loop;
                    end if;
                    --

                    RETURN v_mod_id;
              END;$BODY$
        LANGUAGE plpgsql VOLATILE
        COST 100;
    "
  end
end
