Pod::Spec.new do |s|

    s.name = 'LGHelper'
    s.version = '1.0.3'
    s.platform = :ios, '6.0'
    s.license = 'MIT'
    s.homepage = 'https://github.com/Friend-LGA/LGHelper'
    s.author = { 'Grigory Lutkov' => 'Friend.LGA@gmail.com' }
    s.source = { :git => 'https://github.com/Friend-LGA/LGHelper.git', :tag => s.version }
    s.summary = 'iOS helper contains a lot of useful macrosses, methods and hints for every day'

    s.requires_arc = true

    s.source_files = 'LGHelper/*.{h,m}'

    s.dependency 'Reachability', '~> 3.2'

end
