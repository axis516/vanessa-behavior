﻿//начало текста модуля

#Область Служебные_функции_и_процедуры

&НаКлиенте
// контекст фреймворка Vanessa-Behavior
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
    Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"РежимЗапускаПриложения(Парам01)","РежимЗапускаПриложения","Тогда режим запуска приложения ""ТолстыйКлиентУправляемоеПриложение""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВТЧДанныеКлиентовТестированияVanessaBehavoirСодержитьсяСтрока(ТабПарам)","ВТЧДанныеКлиентовТестированияVanessaBehavoirСодержитьсяСтрока","И     в ТЧ ДанныеКлиентовТестирования VanessaBehavoir содержиться строка:");

	Возврат ВсеТесты;
КонецФункции
	
&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции
	
&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции

#КонецОбласти



#Область Работа_со_сценариями

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт
	ОчиститьЖР();
КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры

#КонецОбласти

&НаСервере
Процедура ОчиститьЖР()
	Отбор = Новый Структура;
	Отбор.Вставить("Событие", "_$Session$_.Start");
	ОчиститьЖурналРегистрации(Отбор);
КонецПроцедуры

///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//Тогда режим запуска приложения "ТолстыйКлиентУправляемоеПриложение"
//@РежимЗапускаПриложения(Парам01)
Процедура РежимЗапускаПриложения(Парам01) Экспорт

	ТипЗапуска = ПолучитьТипЗапускаПриложения();

	Если ТипЗапуска <> Парам01 Тогда
		ВызватьИсключение "Запускт приложения не соответствует указанному <" + Парам01 + ">. Определен тип запуска <" + ТипЗапуска + ">";
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьТипЗапускаПриложения()

	ВыгрузкаЖР = Новый ТаблицаЗначений;
	
	Отбор = Новый Структура;
	Отбор.Вставить("Событие", "_$Session$_.Start");
	ВыгрузитьЖурналРегистрации(ВыгрузкаЖР, Отбор);
	
	Если ВыгрузкаЖР.Количество() = 1 Тогда
		Возврат ВыгрузкаЖР[0].ПредставлениеПриложения;
	КонецЕсли;

	Возврат Ложь;
	
КонецФункции // ПолучитьТипЗапускаПриложения()

//окончание текста модуля

&НаКлиенте
//И     в ТЧ ДанныеКлиентовТестирования VanessaBehavoir содержиться строка:
//@ВТЧДанныеКлиентовТестированияVanessaBehavoirСодержитьсяСтрока(ТабПарам)
Процедура ВТЧДанныеКлиентовТестированияVanessaBehavoirСодержитьсяСтрока(ТабПарам) Экспорт

	ДанныеКлиентовТестирования = Ванесса.ДанныеКлиентовТестирования;
	
	Шапка = ТабПарам[0];
	ТабПарамЗначения = ТабПарам[1];
	Отбор = Новый Структура;
	ПутьКПлатформе = Неопределено;
	Для ккк = 1 По Шапка.Количество() Цикл
		ИмяКолонки = Неопределено;
		Шапка.Свойство("Кол" + ккк, ИмяКолонки);
		
		ЗначениеКолонки = Неопределено;
		ТабПарамЗначения.Свойство("Кол" + ккк, ЗначениеКолонки);
		
		Если ИмяКолонки = "Имя" Тогда
			Отбор.Вставить(ИмяКолонки, ЗначениеКолонки);
		ИначеЕсли  ИмяКолонки = "ПортЗапускаТестКлиента" Тогда 
			Отбор.Вставить(ИмяКолонки, Число(ЗначениеКолонки));
		ИначеЕсли ИмяКолонки = "ПутьКПлатформе" Тогда
			ПутьКПлатформе = ЗначениеКолонки;
		КонецЕсли;
	КонецЦикла;
	
	НайденныеСтрока = ДанныеКлиентовТестирования.НайтиСтроки(Отбор);	
	Если НайденныеСтрока.Количество() > 0 Тогда
		НайденнаяСтрока = НайденныеСтрока[0];
		Если ЗначениеЗаполнено(ПутьКПлатформе) Тогда
			Если Не Ванесса.ЭтоLinux Тогда
				ПутьКПлатформе = ПутьКПлатформе + ".exe";
			КонецЕсли;
			Если Сред(НайденнаяСтрока.ПутьКПлатформе, СтрДлина(НайденнаяСтрока.ПутьКПлатформе) - СтрДлина(ПутьКПлатформе)+1) <> ПутьКПлатформе Тогда
				ВызватьИсключение "Ошибка заполнения ТЧ <Данные клиентов тестирования>. Колонка <Путь к платформе> не соответствует эталону";
			КонецЕсли;			
		КонецЕсли;
	Иначе
		ВызватьИсключение "Ошибка заполнения ТЧ <Данные клиентов тестирования>";
	КонецЕсли;
	
КонецПроцедуры
