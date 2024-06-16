import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppTxt {
  static const appName = 'DDX Fitness';
  static const login = 'Логин';
  static const password = 'Пароль';
  static const passwordRepeat = 'Повторить пароль';
  static const btnLogin = 'Войти';
  static const btnRegistration = 'Зарегистрироваться';
  static const registrationTitle = 'Регистрация';
  static const btnCreateAccount = 'Создать аккаунт';
  static const editProfileTitle = 'Заполните анкету';
  static const name = 'Фамилия Имя Отчество';
  static const phone = 'Телефон';
  static const birthdate = 'Дата рождения';
  static const male = 'Мужчина';
  static const female = 'Женщина';
  static const btnEditProfile = 'Заполнить';
  static const btnGoToEditProfile = 'Редактировать профиль';
  static const sex = 'Пол';
  static const male_s = 'Мужской';
  static const female_s = 'Женский';
  static const btnLogout = 'Выйти из аккаунта';

  static const btnShowState = 'Посмотреть статистику';
  static const btnShowTask = 'Перейти к тренировкам';
  static const btnAddTask = 'Добавить занятие';

  static const tabClients = 'Клиенты';
  static const tabExercises = 'Упражнения';
  static const tabDiscussions = 'Обсуждения';
  static const tabProfile = 'Профиль';
  static const tabTasks = 'Тренировки';
  static const tabState = 'Прогресс';

  static const segmentPublic = 'Общие';
  static const segmentPrivate = 'Личные';

  static const titleExercise = 'Упражнение';
  static const titleAddExercises = 'Новое упражнение';
  static const titleTasks = 'Тренировки';
  static const titleTask = 'Задание';
  static const titleTasksExecute = 'Упражнение';

  static const lvlEasy = 'Начинающий';
  static const lvlMedium = 'Средний';
  static const lvlHard = 'Профессионал';

  static const descriptionTitle = 'Название упражнения';
  static const descriptionTitleExample = 'Название';
  static const descriptionMuscle = 'Прорабатываемая группа мышц:';
  static const descriptionType = 'Тип упражнения:';
  static const descriptionEquipment = 'Необходимое оборудование:';
  static const descriptionDifficulty = 'Уровень подготовки:';
  static const descriptionAdditionalInfo = 'Дополнительная информация:';

  static const btnCreateExercise = 'Составить упражнение';
  static const btnAddExercise = 'Добавить к себе';
  static const btnAdd = 'Добавить';
  static const btnCancel = 'Отмена';
  static const btnAddExerciseDialogTitle =
      'Текущее упражнение будет добавлено в ваш личный список упражнений';

  static const addDescription = 'Можете добавить описание';

  static const errorListIsEmpty = 'Список пуст';
  static const createExercise = 'Вы можете составить первое упражнение';

  static const selectExerciseParams =
      'Установите параметры для выполнения упражнения';

  static const weight = 'Вес снаряда';
  static const timeMin = 'Уложиться во время (сек)';
  static const timeMax = 'Прожержаться (сек)';
  static const setCount = 'Кол-во подходов';
  static const repeatCount = 'Кол-во повторений';
  static const description = 'Описание';
  static const kg = '\tкг.';
  static const target = 'Цель';
  static const sec = ' cек.';
  static const count = ' раз ';
  static const difficultyClientCompleteForClient = 'Вы оценили сложность выполнения упражнения на:\t';
  static const difficultyClientCompleteForTrainer = 'Клиент оценил сложность упражнения на:\t';
  static const gradeTrainerCompleteForTrainer = 'Вы оценили выполнение упражнения на:\t';
  static const gradeTrainerCompleteForClient = 'Тренер оценил ваше выполнение упражнения на:\t';
  static const gradeTrainer = 'Оценить выполнение на:\t';
  static const difficultyClient = 'Оценить сложность на:\t';
  static const goToMsg = 'Перейти к обсуждению';
  static const tryAgain = 'Повторить';
  static const yourResults = 'Ваши результаты:';
  static const sendResultClient = 'Отправить результаты';
  static const enterYourMsg = 'Введите сообщение';

  static const errorServerResponse = 'Ошибка соединения с сервером';
  static const errorLoginOrPass = 'Неверный логин или пароль';
  static const errorLoginOrPassIsEmpty = 'Введите логин и пароль';
  static const errorInputDataIsEmpty = 'Заполните все поля';
  static const errorPasswordsNotEqual = 'Пароли не совпабают';
  static const errorUserIsAlreadyExist = 'Логин уже занят';
  static const errorTokenFailed = 'Необходимо перезайти в аккаунт';

  static const btnAddFromGallery = 'Выбрать из галереи';
  static const btnAddFromCamera = 'Открыть камеру';
  static const titleAddPhoto = 'Добавьте изображения';
  static const btnUploadPhoto = 'Загрузить изображение';
  static const btnComplete = 'Завершить';
  static const btnResetExercise = 'Выбрать другое упражнение';
  static const btnCreateTask = 'Составить занятие';

  static const fileUploadSuccess = 'Файл загружен';
  static const uploadedFilesCount = 'Загружено файлов:';

  static const taskListEmptyDescription = 'На этот день занятий не назначено';
  static const exerciseListEmptyDescription =
      'У вас пока нет своих упражнений, можете составить сами или добавить из общих упражнений';
  static const discussionListEmptyDescription =
      'У вас пока нет обсуждений по упражнениям';

  static const errTextTitleDefault = 'Что-то не так';
  static const errTextDescriptionDefault = 'Попробуйте снова';
  static const errBtnTextDefault = 'Обновить';

  static const emptyDataDropdown = 'Выбрать';

  static List<DropdownMenuItem<String>> musculeDropdownItems = [
    DropdownMenuItem(
        child: Text("Выбрать", overflow: TextOverflow.visible),
        value: "Выбрать"),
    DropdownMenuItem(
        child: Text("Абдукторы", overflow: TextOverflow.visible),
        value: "Абдукторы"),
    DropdownMenuItem(
        child: Text("Аддукторы", overflow: TextOverflow.visible),
        value: "Аддукторы"),
    DropdownMenuItem(
        child: Text("Бедра", overflow: TextOverflow.visible), value: "Бедра"),
    DropdownMenuItem(
        child: Text("Бицепс", overflow: TextOverflow.visible), value: "Бицепс"),
    DropdownMenuItem(
        child: Text("Грудь", overflow: TextOverflow.visible), value: "Грудь"),
    DropdownMenuItem(
        child: Text("Грудь,Квадрицепсы", overflow: TextOverflow.visible),
        value: "Грудь,Квадрицепсы"),
    DropdownMenuItem(
        child: Text("Грудь,Трицепсы", overflow: TextOverflow.visible),
        value: "Грудь,Трицепсы"),
    //DropdownMenuItem(child: Text("Грудь,Широчайшие мышцы спины",overflow: TextOverflow.visible), value: "Грудь,Широчайшие мышцы спины"),
    DropdownMenuItem(
        child: Text("Другое", overflow: TextOverflow.visible), value: "Другое"),
    DropdownMenuItem(
        child: Text("Икры", overflow: TextOverflow.visible), value: "Икры"),
    DropdownMenuItem(
        child: Text("Квадрицепсы", overflow: TextOverflow.visible),
        value: "Квадрицепсы"),
    DropdownMenuItem(
        child: Text("Нижняя часть спины", overflow: TextOverflow.visible),
        value: "Нижняя часть спины"),
    DropdownMenuItem(
        child: Text("Плечи", overflow: TextOverflow.visible), value: "Плечи"),
    //DropdownMenuItem(child: Text("Плечи,Трицепсы,Широчайшие мышцы спины",overflow: TextOverflow.visible), value: "Плечи,Трицепсы,Широчайшие мышцы спины"),
    DropdownMenuItem(
        child: Text("Предплечья", overflow: TextOverflow.visible),
        value: "Предплечья"),
    DropdownMenuItem(
        child: Text("Пресс", overflow: TextOverflow.visible), value: "Пресс"),
    DropdownMenuItem(
        child: Text("Средняя часть спины", overflow: TextOverflow.visible),
        value: "Средняя часть спины"),
    DropdownMenuItem(
        child: Text("Трапеции", overflow: TextOverflow.visible),
        value: "Трапеции"),
    DropdownMenuItem(
        child: Text("Трицепсы", overflow: TextOverflow.visible),
        value: "Трицепсы"),
    DropdownMenuItem(
        child: Text("Шея", overflow: TextOverflow.visible), value: "Шея"),
    DropdownMenuItem(
        child: Text("Широчайшие мышцы спины", overflow: TextOverflow.visible),
        value: "Широчайшие мышцы спины"),
    DropdownMenuItem(
        child: Text("Ягодицы", overflow: TextOverflow.visible),
        value: "Ягодицы"),
  ];

  static List<DropdownMenuItem<String>> typeDropdownItems = [
    DropdownMenuItem(
        child: Text("Выбрать", overflow: TextOverflow.visible),
        value: "Выбрать"),
    DropdownMenuItem(
        child: Text("Базовое", overflow: TextOverflow.visible),
        value: "Базовое"),
    DropdownMenuItem(
        child: Text("Изолирующее", overflow: TextOverflow.visible),
        value: "Изолирующее"),
  ];

  static List<DropdownMenuItem<String>> equipmentDropdownItems = [
    DropdownMenuItem(
        child: Text("Выбрать", overflow: TextOverflow.visible),
        value: "Выбрать"),
    DropdownMenuItem(
        child: Text("Гантели", overflow: TextOverflow.visible),
        value: "Гантели"),
    DropdownMenuItem(
        child: Text("Гири", overflow: TextOverflow.visible), value: "Гири"),
    DropdownMenuItem(
        child: Text("Другое", overflow: TextOverflow.visible), value: "Другое"),
    DropdownMenuItem(
        child: Text("Другое,Фитбол", overflow: TextOverflow.visible),
        value: "Другое,Фитбол"),
    DropdownMenuItem(
        child: Text("Машина Смита", overflow: TextOverflow.visible),
        value: "Машина Смита"),
    DropdownMenuItem(
        child: Text("Отсутствует", overflow: TextOverflow.visible),
        value: "Отсутствует"),
    DropdownMenuItem(
        child: Text("Силовая рама,Штанга", overflow: TextOverflow.visible),
        value: "Силовая рама,Штанга"),
    DropdownMenuItem(
        child: Text("Тренажер", overflow: TextOverflow.visible),
        value: "Тренажер"),
    DropdownMenuItem(
        child: Text("Тросовые тренажеры", overflow: TextOverflow.visible),
        value: "Тросовые тренажеры"),
    DropdownMenuItem(
        child: Text("Турник", overflow: TextOverflow.visible), value: "Турник"),
    DropdownMenuItem(
        child: Text("Фитбол", overflow: TextOverflow.visible), value: "Фитбол"),
    DropdownMenuItem(
        child: Text("Штанга", overflow: TextOverflow.visible), value: "Штанга"),
    DropdownMenuItem(
        child: Text("Эспандер", overflow: TextOverflow.visible),
        value: "Эспандер"),
  ];
  static List<DropdownMenuItem<String>> difficultyDropdownItems = [
    DropdownMenuItem(
        child: Text("Выбрать", overflow: TextOverflow.visible),
        value: "Выбрать"),
    DropdownMenuItem(
        child: Text(lvlEasy, overflow: TextOverflow.visible), value: lvlEasy),
    DropdownMenuItem(
        child: Text(lvlMedium, overflow: TextOverflow.visible),
        value: lvlMedium),
    DropdownMenuItem(
        child: Text(lvlHard, overflow: TextOverflow.visible), value: lvlHard),
  ];
}

class Tag extends Equatable {
  String name = "tag";

  @override
  List<Object> get props => [name];
}
