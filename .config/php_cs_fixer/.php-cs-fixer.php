<?php

$config = new PhpCsFixer\Config();

return $config
  ->setRules([
        '@PSR12' => true,  // PSR12 をベースとする
        'single_quote' => true,  // シングルクォーテーションを使用
        'visibility_required' => [
            'elements' => ['method', 'property']  // const には visibility を付けない
        ],
        'single_blank_line_at_eof' => true,  // ファイル末尾に1行空行を入れる
        'no_whitespace_in_blank_line' => true, // 空行に余分な空白を入れない
        'constant_case' => [
            'case' => 'lower'  // true, false, null を小文字に
        ],
        'no_extra_blank_lines' => [
            'tokens' => [
              // 'extra', // 一般的な余分な空行を削除
              'curly_brace_block', // 波括弧ブロック内の余分な空行を制御
              'use', // use 文の間の余分な空行を削除
            ]
        ],
        'class_attributes_separation' => [
            'elements' => [
              'const' => 'none',    // 定数間の空行を削除
              'property' => 'none', // プロパティ間の空行を削除
              'method' => 'one',    // メソッド間は1行の空行を維持
            ]
        ],
        'single_class_element_per_statement' => [
            'elements' => [ 'const', 'property' ]
        ],
        'blank_line_before_statement' => [
          'statements' => ['return', 'throw', 'try']  // 特定の文の前に空行を入れる
        ],
        'phpdoc_separation' => true, // PHPDoc ブロック内の適切な空行を追加
        'phpdoc_align' => [
          'align' => 'vertical',
        ],
        // indentation
        'array_indentation' => true, // 配列のインデントを揃える
        'method_chaining_indentation' => true, // メソッドチェーンのインデントを揃える
    ])
    ->setFinder(
        PhpCsFixer\Finder::create()
            ->in(__DIR__)
            ->exclude(['vendor', 'var'])  // vendor ディレクトリを除外
    )
    ->setUsingCache(false)  // キャッシュを無効化
;

