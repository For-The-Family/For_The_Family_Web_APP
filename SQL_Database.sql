PGDMP       !        
        |            FTF_SQL    16.4    16.4 -    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    24909    FTF_SQL    DATABASE     k   CREATE DATABASE "FTF_SQL" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE "FTF_SQL";
                asmodeus_cruentus    false            �           0    0    DATABASE "FTF_SQL"    ACL     7   GRANT CONNECT ON DATABASE "FTF_SQL" TO website_reader;
                   asmodeus_cruentus    false    4831            �           0    0    SCHEMA public    ACL     0   GRANT USAGE ON SCHEMA public TO website_reader;
                   pg_database_owner    false    5            �            1259    24949 
   activities    TABLE     n   CREATE TABLE public.activities (
    id integer NOT NULL,
    activity_name character varying(50) NOT NULL
);
    DROP TABLE public.activities;
       public         heap    asmodeus_cruentus    false            �           0    0    TABLE activities    ACL     ;   GRANT SELECT ON TABLE public.activities TO website_reader;
          public          asmodeus_cruentus    false    218            �            1259    24948    activities_id_seq    SEQUENCE     �   CREATE SEQUENCE public.activities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.activities_id_seq;
       public          asmodeus_cruentus    false    218            �           0    0    activities_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.activities_id_seq OWNED BY public.activities.id;
          public          asmodeus_cruentus    false    217            �            1259    24973 
   facilities    TABLE     n   CREATE TABLE public.facilities (
    id integer NOT NULL,
    facility_name character varying(50) NOT NULL
);
    DROP TABLE public.facilities;
       public         heap    asmodeus_cruentus    false            �           0    0    TABLE facilities    ACL     ;   GRANT SELECT ON TABLE public.facilities TO website_reader;
          public          asmodeus_cruentus    false    221            �            1259    24972    facilities_id_seq    SEQUENCE     �   CREATE SEQUENCE public.facilities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.facilities_id_seq;
       public          asmodeus_cruentus    false    221            �           0    0    facilities_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.facilities_id_seq OWNED BY public.facilities.id;
          public          asmodeus_cruentus    false    220            �            1259    24957    kindergarten_activities    TABLE     �   CREATE TABLE public.kindergarten_activities (
    kindergarten_id integer NOT NULL,
    activity_id integer NOT NULL,
    is_available boolean NOT NULL
);
 +   DROP TABLE public.kindergarten_activities;
       public         heap    asmodeus_cruentus    false            �           0    0    TABLE kindergarten_activities    ACL     H   GRANT SELECT ON TABLE public.kindergarten_activities TO website_reader;
          public          asmodeus_cruentus    false    219            �            1259    24981    kindergarten_facilities    TABLE     �   CREATE TABLE public.kindergarten_facilities (
    kindergarten_id integer NOT NULL,
    facility_id integer NOT NULL,
    is_available boolean NOT NULL
);
 +   DROP TABLE public.kindergarten_facilities;
       public         heap    asmodeus_cruentus    false            �           0    0    TABLE kindergarten_facilities    ACL     H   GRANT SELECT ON TABLE public.kindergarten_facilities TO website_reader;
          public          asmodeus_cruentus    false    222            �            1259    24938    kindergartens    TABLE     |  CREATE TABLE public.kindergartens (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    street_address character varying(255),
    city character varying(255),
    postal_code character varying(10),
    latitude numeric(8,5),
    longitude numeric(8,5),
    opening_hours character varying(50),
    minimum_age integer,
    image_path character varying(255)
);
 !   DROP TABLE public.kindergartens;
       public         heap    asmodeus_cruentus    false            �           0    0    TABLE kindergartens    ACL     >   GRANT SELECT ON TABLE public.kindergartens TO website_reader;
          public          asmodeus_cruentus    false    216            �            1259    24937    kindergartens_id_seq    SEQUENCE     �   CREATE SEQUENCE public.kindergartens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.kindergartens_id_seq;
       public          asmodeus_cruentus    false    216            �           0    0    kindergartens_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.kindergartens_id_seq OWNED BY public.kindergartens.id;
          public          asmodeus_cruentus    false    215            -           2604    24952    activities id    DEFAULT     n   ALTER TABLE ONLY public.activities ALTER COLUMN id SET DEFAULT nextval('public.activities_id_seq'::regclass);
 <   ALTER TABLE public.activities ALTER COLUMN id DROP DEFAULT;
       public          asmodeus_cruentus    false    217    218    218            .           2604    24976    facilities id    DEFAULT     n   ALTER TABLE ONLY public.facilities ALTER COLUMN id SET DEFAULT nextval('public.facilities_id_seq'::regclass);
 <   ALTER TABLE public.facilities ALTER COLUMN id DROP DEFAULT;
       public          asmodeus_cruentus    false    220    221    221            ,           2604    24941    kindergartens id    DEFAULT     t   ALTER TABLE ONLY public.kindergartens ALTER COLUMN id SET DEFAULT nextval('public.kindergartens_id_seq'::regclass);
 ?   ALTER TABLE public.kindergartens ALTER COLUMN id DROP DEFAULT;
       public          asmodeus_cruentus    false    216    215    216            �          0    24949 
   activities 
   TABLE DATA           7   COPY public.activities (id, activity_name) FROM stdin;
    public          asmodeus_cruentus    false    218    6       �          0    24973 
   facilities 
   TABLE DATA           7   COPY public.facilities (id, facility_name) FROM stdin;
    public          asmodeus_cruentus    false    221   �6       �          0    24957    kindergarten_activities 
   TABLE DATA           ]   COPY public.kindergarten_activities (kindergarten_id, activity_id, is_available) FROM stdin;
    public          asmodeus_cruentus    false    219   �6       �          0    24981    kindergarten_facilities 
   TABLE DATA           ]   COPY public.kindergarten_facilities (kindergarten_id, facility_id, is_available) FROM stdin;
    public          asmodeus_cruentus    false    222   �=       �          0    24938    kindergartens 
   TABLE DATA           �   COPY public.kindergartens (id, name, street_address, city, postal_code, latitude, longitude, opening_hours, minimum_age, image_path) FROM stdin;
    public          asmodeus_cruentus    false    216   �?       �           0    0    activities_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.activities_id_seq', 1, false);
          public          asmodeus_cruentus    false    217            �           0    0    facilities_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.facilities_id_seq', 1, false);
          public          asmodeus_cruentus    false    220            �           0    0    kindergartens_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.kindergartens_id_seq', 1, false);
          public          asmodeus_cruentus    false    215            4           2606    24956 '   activities activities_activity_name_key 
   CONSTRAINT     k   ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_activity_name_key UNIQUE (activity_name);
 Q   ALTER TABLE ONLY public.activities DROP CONSTRAINT activities_activity_name_key;
       public            asmodeus_cruentus    false    218            6           2606    24954    activities activities_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.activities DROP CONSTRAINT activities_pkey;
       public            asmodeus_cruentus    false    218            :           2606    24980 '   facilities facilities_facility_name_key 
   CONSTRAINT     k   ALTER TABLE ONLY public.facilities
    ADD CONSTRAINT facilities_facility_name_key UNIQUE (facility_name);
 Q   ALTER TABLE ONLY public.facilities DROP CONSTRAINT facilities_facility_name_key;
       public            asmodeus_cruentus    false    221            <           2606    24978    facilities facilities_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.facilities
    ADD CONSTRAINT facilities_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.facilities DROP CONSTRAINT facilities_pkey;
       public            asmodeus_cruentus    false    221            8           2606    24961 4   kindergarten_activities kindergarten_activities_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.kindergarten_activities
    ADD CONSTRAINT kindergarten_activities_pkey PRIMARY KEY (kindergarten_id, activity_id);
 ^   ALTER TABLE ONLY public.kindergarten_activities DROP CONSTRAINT kindergarten_activities_pkey;
       public            asmodeus_cruentus    false    219    219            >           2606    24985 4   kindergarten_facilities kindergarten_facilities_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.kindergarten_facilities
    ADD CONSTRAINT kindergarten_facilities_pkey PRIMARY KEY (kindergarten_id, facility_id);
 ^   ALTER TABLE ONLY public.kindergarten_facilities DROP CONSTRAINT kindergarten_facilities_pkey;
       public            asmodeus_cruentus    false    222    222            0           2606    24947 $   kindergartens kindergartens_name_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.kindergartens
    ADD CONSTRAINT kindergartens_name_key UNIQUE (name);
 N   ALTER TABLE ONLY public.kindergartens DROP CONSTRAINT kindergartens_name_key;
       public            asmodeus_cruentus    false    216            2           2606    24945     kindergartens kindergartens_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.kindergartens
    ADD CONSTRAINT kindergartens_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.kindergartens DROP CONSTRAINT kindergartens_pkey;
       public            asmodeus_cruentus    false    216            ?           2606    24967 @   kindergarten_activities kindergarten_activities_activity_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.kindergarten_activities
    ADD CONSTRAINT kindergarten_activities_activity_id_fkey FOREIGN KEY (activity_id) REFERENCES public.activities(id) ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.kindergarten_activities DROP CONSTRAINT kindergarten_activities_activity_id_fkey;
       public          asmodeus_cruentus    false    219    4662    218            @           2606    24962 D   kindergarten_activities kindergarten_activities_kindergarten_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.kindergarten_activities
    ADD CONSTRAINT kindergarten_activities_kindergarten_id_fkey FOREIGN KEY (kindergarten_id) REFERENCES public.kindergartens(id) ON DELETE CASCADE;
 n   ALTER TABLE ONLY public.kindergarten_activities DROP CONSTRAINT kindergarten_activities_kindergarten_id_fkey;
       public          asmodeus_cruentus    false    4658    219    216            A           2606    24991 @   kindergarten_facilities kindergarten_facilities_facility_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.kindergarten_facilities
    ADD CONSTRAINT kindergarten_facilities_facility_id_fkey FOREIGN KEY (facility_id) REFERENCES public.facilities(id) ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.kindergarten_facilities DROP CONSTRAINT kindergarten_facilities_facility_id_fkey;
       public          asmodeus_cruentus    false    4668    222    221            B           2606    24986 D   kindergarten_facilities kindergarten_facilities_kindergarten_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.kindergarten_facilities
    ADD CONSTRAINT kindergarten_facilities_kindergarten_id_fkey FOREIGN KEY (kindergarten_id) REFERENCES public.kindergartens(id) ON DELETE CASCADE;
 n   ALTER TABLE ONLY public.kindergarten_facilities DROP CONSTRAINT kindergarten_facilities_kindergarten_id_fkey;
       public          asmodeus_cruentus    false    216    222    4658            �   s   x�=ͻ
�@F�z�wـwm7 ؉ki3q�08�@vA?6��8pVٌ�)!}���5E�C�����\�	�Ԛ��y�A����ؗrOWV���m�%�܍_)�f���:-�G`�)A      �   1   x�3�t��OQPSp)���.�2�H,���K�2����I-)����� ��      �   �  x�-�Kr$)�u�0c">u�Y�	��6�
+UGCez��<�O�����?����w�1��ʐ��?��Q>�G�(�|����S��w���a8�1��>���o��??������~��yc�1�������.�g��!�0�R�>��uW�3|�p���?��T���[f�<����g(Cny*O�O��{~���ʐ�{]�;�r�\;W��k��Y�%ǝ҂�Vŭ�ڸU�j�Vj��i�ydު�?1o�֭�[Uw��צ�\uZݹꮰnUߪ�U}����w��s����\}�����%�����s�1��C0��#�	� �?w��?��ߪ'�s�=���nw��v��jw�L(yO�{P��������N���3�w����<&�/����܋�E�
儯0;1���"|Q��Y�,pV�=��΂g�_O8@�̎�*�C�Jy����j�o�m�0�V��j��ىZH-���_>�xz��"k���Zp-��(�}��5�؂lQ�0[v��-��؏�?������-�s�c��u!W�[P�ՠ.�e�\�oiA]PK�t
�B>��
ꂺx�B�ԋ)�r5���xQw�A]P�uA]�Ր�A]��.��ꂺ�.�ꂺ�.�W��`A]P�uA]Pԅ$Qԅ0m=�Ġ.��Q��ǘ]��TꂺlA]�][�cv��-�[P�u!ズ�.���r��c�.�K꒺�.�K�R�%u)뒺\�u)�RSL�R�%uI]R�ԥ�KY��.e]ʺ�.���"_�|M�u��&_��._��uI]R��eR��eR�:fj�I]R��%uI]�r꒺�.�K��v,�K꒺�u)뒺�K꒺�uI]R��.�K꒺�.e]ʺ�uI]R��.�ˣ���u���G���%u)�R�%uE]�E]QW��%늺���+YWԕ�+YW:lɺ���+�J�-YW�uE]QW:l�E]��xYW���+��+YWo�F]ɺ*�˺*�o��6j�uE]鰥�ue�Vԕ[ٲu%늺��a���uE]ɺ��tؒuE]�E]QW�pE]QW�uE]�E]QW�uE]ɺ�u%�J�u�Q.�J�u���Ե}]�׵�k�ھ��k�Z�5u-뚺��e]S��5uM]˺�a[�m��k�Z�5uM]˺�u-뚺�u�ö�k�ھ��kꚺ�uM]S��������	���	� 뚺���k�Zֵ۲��kY�Ե�kꚺ�u�ö�CS��5u�ö�:lS��5uM]�M]S�Ե�kY��u-�Zֵ�k�6u[���mY�e��a����m궬��m�6u��-�6u��MݦnS����mY���:�nS��۲n˺MݦnS��۲nS����mv받�Mݦn˺M�v�زnS����m��e�~��w@}'�wD}gTY�eݦnS����m�6u��MݦnS����m�6u[�m��Ķ���m�6u[���m�6u[�m�6u[�m�F�Y7:�Ⱥ�u#�F�uC�Ⱥq�v��ƾnd�P7^xuC�谣Î;�uC��C��׍�Y7:�8MuC�P7�uC�Ⱥ�uC�P7ԍ�ꆺ�n�ꆺi�nd�P7�u�;ԍ;ԍ�ꆺy�G�����!y�Ht�y/I�[������a���uc_7ԍ�ꆺ�n��F�vd�谣�uCݡ�Pwdݑu��#뎬;��u��Cݑu��C���Pw�;N��Cݡ�谇����uG�Yw�;�Yw�;��uǾ�PwdݑuǾ�Pw�;��u��c_w���đuG��u������?����      �   �  x�-�Inc9@��u���́�K��}����x�C)���~�{�Ͼ����s�gٖo\u�gٖ[l��G�3�g��o�-�oܿ7~�m�1�C\����-n1Eʍ��6�&�D�hm�M��6�&�D�hm�$J�$J�$J�$J�$J�$J�$��܈�(��(��(��(��(��(��(��������������������������������������������������������������������������������������������h��h��h��h��h��h��h��h��h��h��h��h��h��h��h����Ct��!:D���Ct��!:D����{������//�u����)߿�����������o���Ş�[�-6�}�����+�F��v#�)�1���J��v�aôa7"���C@ĳ�v� �|��K=��r~~��OG�Bt�k��׳͎r~9��(W��_y�������e]"�      �   �
  x��Z͎��>�����26��6�=��c/�r�K.=EQ�!�&)`n�˾�{�!�\�a �``s��IR]Ք(�+D�4MiT��ꫪ�v�y[7���d�.�;.Ҽ��k��Ɗl�Sz[���{(�c{,��;^b���u�'�+;���3�	����7<K��~�/� �כ���k����U�(�m��Ҋ�C,w�F𿥫J,R�`�~ˆ�zs��7��2���b�4�z���6��ݧ��^ZΡR�=go�@�4ݗ���]��m�Y��o�i��J��/
2�Lt��E{�{v�g'��v�-b�5�_����^�����[/�y��_�$�oL{��/�b6KA׷�<�m���C���PR�bB-��u��K+y�4��e#� l�]�E.�L�EQ?�	�r	�a3� ���8�[ݝ����Ą����4��]�)�!�i�I����^J�,���4/��S��X�2�[$1x��wp&��"���^rч�?��%�v��?��q��iL�}�;9M�9M����Km9F|u'��B����D5 ^�endj'��"v�=,I/\���<P�r�S�.���hǅHoKv�R�xZ�z�^�y- �Z�C�V�uS��"nh�7��)��좕�rJ	y�[��^-��p��&�,�T;X`Kr�XX�kĢZ.Ḑ@��*p�L=�)j�d���#�i����SB�ʁU�:������CE}��B�]�k��F4Ӓ	)P��y�3�)���FR�%G�{w	�%��\�%{���e��� 2�FݣK01�LsE�TӦ*�S�������Bܯ�9ץWx�H����Q�;�{R���Z�{B.�k���$�a�`��2��N������f;�傷?
݈�ݧV��K�u��Ub�#�v��}�v�
aE�F5�t �9��.[�hW)������!Hpf��@<!�M���F��"#�ț�Z0T��2�]�W��Am{D�M$�7�&���i�5���ET�ފT�{y+WȌV`i'����7�ȼݝ
_��{���S�mC��=�7��x�uwR9Fl�1��B��䰷[��Ȅ��Z'4�{ل�+�f�bylA� $hU٘7&�;�|�� ��xX�*�e+��B�9g���w�WxK(�	q��xb�!I2��
���8�fSc@+�5bE�L8���+���U2�{��-���n1�L�� 1�73~��u_�#�WWy#rK}��P7ja�F�Eߴ���y�=��<o*9 v�;(�иW9�j�J��kU�����tZZ}�/��|.h|Wr�sث,KeCh�������;n��ݣ.P�h��ƹ�P�>�~����%��܈5tL��c]�j �n�-R�#V��,1Q+��A�F�w��Hد�)��ꛟ�.L�ȽxTUwEf���f"͋u[ B-��܉'����JW��k�r(�#���k֯�P�>~�0�Ԡ8�� axꦊ�A�w	��L�6!��|hˬ�v���yB��j�ï�VAM\#�ӂ	��p[��e�R~��c�z;�=��/���M�	b�W���G�c�Q�C���=��#�ּ]�fa����@��"TU����,H(z"F��.t�&vjf��]�b#��L��v��E�RƉh�aʜ�{���,[u��.d��q��A���2zrb���&]6!C&�F��֭ �&�Q�kBr�%���?+)��,���2rه��D��7�۳�s�B ����沄D����i��j"Rs^�m�:�hU�57�x��k�s#0��������EX��\f�ʄ*���,��
�K.pP�yϬt)���������{sQ�?�����ߩ��"�ƒ�����p�`f�v�	*F(�p���^��kk���>��lgjK�{�ݿ�꼬��O%�c�i�������/\,*�<��9��e.1�6����a�/Y^c�
瓖R�@��Z6�� ���z�C��#���,�T������B�LX�<�ޖMNh�p�o���	��<:4��?��u����yreg�����@U��%8�.}=���)���GgJ�	�К���1�O�%��-d��ɢ�w^f��:Cz�=n�ϘK���؇�Wh����ЊJ��i E�\�����|��<�`�&!x�79I�h,���3�9Xe���y�s�v��UZ�����õ�Gࠓ����;E7�:�	3�nut����b���!5-uቃ=[ߺ���c��q-���o��������,5n_Xǽ!�-9�	z,�L�^X�s!�~�\�����ޙ,�6T
s����gj�}�.���ZQt��7@��M��^"t��n`͹�	��!}[�Qx�v�\&�/c�����hL9�o�޲8�*?�zq���	���%��q?O�M���`^N�yzL2W�J�Xb��_��ʾ9����O�T+D ̄d�_�ݝ����4�&Pi��Oj5��e���j�2�E�Al�Ǡ�8������O.�A�����-#�w���hP�9�I��?����E��j8�� ��><	�����$'D�S��I���T���:��K�e���e���|���F�Q0;�!�#d�,(׭��ӅFh�n�.1�Uٮ��ߨ�ԫ+��ƃ�Nҕ�G�6�xh�_EL��D��"$Ox�V.p� �[D�ku#�)�O����8�F���vd;T���^'D�1���ٳg��/��     