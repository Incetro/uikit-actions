Pod::Spec.new do |spec|
  spec.name          = 'uikit-actions'
  spec.module_name   = 'UIKitActions'
  spec.version       = '0.0.2'
  spec.license       = 'MIT'
  spec.authors       = { 'incetro' => 'incetro@ya.ru' }
  spec.homepage      = "https://github.com/Incetro/uikit-actions.git"
  spec.summary       = 'An elegant way to add swift closures to UIView, UIControl and more'
  spec.platform      = :ios, "12.0"
  spec.swift_version = '4.0'
  spec.source        = { git: "https://github.com/Incetro/uikit-actions.git", tag: "#{spec.version}" }
  spec.source_files  = "Sources/UIKitActions/**/*.{h,swift}"
end