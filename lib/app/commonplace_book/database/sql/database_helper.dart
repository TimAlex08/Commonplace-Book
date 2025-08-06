// Dart Imports
import 'dart:io';

// External Imports
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class DatabaseHelper {
  static Database? _database;
  
  Future<Database> get database async {
    if (_database != null) return _database!;
    
    _database = await _initDatabase();
    return _database!;
  }
  
  /// InitDatabase: Crea la base de datos y la tabla si no existe.
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'commonplace_book.db');
    
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, version) async {
        // Tablas principales
        await db.execute(''' 
          CREATE TABLE notebooks(
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            createdAt TEXT,
            lastUpdated TEXT,
            color TEXT,
            coverImage TEXT,
            backCoverImage TEXT,
            isFavorite INTEGER DEFAULT 0,
            isArchived INTEGER DEFAULT 0,
            tags TEXT
          )
        ''');
       
        await db.execute('''
          CREATE TABLE pages (
            id TEXT PRIMARY KEY,
            notebookId TEXT,
            position INTEGER,
            title TEXT,
            createdAt TEXT,
            updatedAt TEXT,
            pageType TEXT,
            FOREIGN KEY (notebookId) REFERENCES notebooks(id) ON DELETE CASCADE
          )
        ''');
        
        await db.execute('''
          CREATE TABLE todos (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            description TEXT,
            dueTime TEXT,
            finishedAt TEXT,
            isCompleted BOOLEAN DEFAULT 0,
            status TEXT,
            priority TEXT,
            createdAt TEXT,
            updatedAt TEXT,
            todoBlockId TEXT,
            FOREIGN KEY (todoBlockId) REFERENCES todo_blocks(id) ON DELETE SET NULL
          )
        ''');
        
        
        // Tablas de Bloques
        await db.execute('''
          CREATE TABLE blocks (
            id TEXT PRIMARY KEY,
            notebookId TEXT,
            pageId TEXT,
            title TEXT,
            createdAt TEXT,
            updatedAt TEXT,
            blockType TEXT,
            FOREIGN KEY (notebookId) REFERENCES notebooks(id) ON DELETE CASCADE,
            FOREIGN KEY (pageId) REFERENCES pages(id) ON DELETE CASCADE
          )
        ''');
        
        await db.execute('''
          CREATE TABLE text_blocks (
            id TEXT PRIMARY KEY,
            blockId TEXT UNIQUE,
            content TEXT,
            FOREIGN KEY (blockId) REFERENCES blocks(id) ON DELETE CASCADE
          )
        ''');
        
        await db.execute('''
          CREATE TABLE quote_blocks (
            id TEXT PRIMARY KEY,
            blockId TEXT UNIQUE,
            quote TEXT,
            author TEXT,
            FOREIGN KEY (blockId) REFERENCES blocks(id) ON DELETE CASCADE
          )
        ''');
        
        await db.execute('''
          CREATE TABLE todo_blocks (
            id TEXT PRIMARY KEY,
            blockId TEXT UNIQUE NOT NULL,
            createdAt TEXT,
            FOREIGN KEY (blockId) REFERENCES blocks(id) ON DELETE CASCADE
          )
        ''');
        
        // Tabla Intermedias
        await db.execute('''
          CREATE TABLE todo_block_items (
            todoBlockId TEXT,
            todoId TEXT,
            PRIMARY KEY (todoBlockId, todoId),
            FOREIGN KEY (todoBlockId) REFERENCES todo_blocks(id) ON DELETE CASCADE,
            FOREIGN KEY (todoId) REFERENCES todos(id) ON DELETE CASCADE
          )
        ''');
      },
    );
  }
}